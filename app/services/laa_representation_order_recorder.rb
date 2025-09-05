# frozen_string_literal: true

class LaaRepresentationOrderRecorder < ApplicationService
  def initialize(params)
    @params = params
    @schema = JSON.parse(File.open(Rails.root.join("lib/schemas/api/progression.recordRepresentationOrder.json")).read)
    register_dependant_schemas!
  end

  def call
    errors = JSON::Validator.fully_validate(schema, permitted_params.to_json)
    raise Errors::InvalidParams, errors if errors.present?

    reference_holder = find_reference_holder

    defendant = reference_holder.defendant

    reference_holder.build_laa_reference if reference_holder.laa_reference.blank?
    defendant.build_defence_organisation if defendant.defence_organisation.blank?

    reference_holder.laa_reference.update!(laa_reference_params)
    defendant.defence_organisation.update!(defence_organisation_params)
    reference_holder.laa_reference
  end

private

  attr_reader :params, :schema

  def permitted_params
    params.permit(:offenceId,
                  :applicationId,
                  :statusCode,
                  :applicationReference,
                  :statusDate,
                  :effectiveStartDate,
                  :effectiveEndDate,
                  defenceOrganisation: {})
  end

  def laa_reference_params
    permitted_params.slice(:statusCode,
                           :applicationReference,
                           :statusDate,
                           :effectiveStartDate,
                           :effectiveEndDate)
                    .merge(statusId: SecureRandom.uuid,
                           statusDescription: "FAKE NEWS")
  end

  def defence_organisation_params
    attributes = permitted_params[:defenceOrganisation].to_h

    attributes.deep_transform_keys! { |x| %w[address contact organisation].include?(x) ? "#{x}_attributes" : x }

    attributes.merge(fundingType: "REPRESENTATION_ORDER",
                     associationStartDate: permitted_params[:effectiveStartDate],
                     associationEndDate: permitted_params[:effectiveEndDate],
                     isAssociatedByLAA: true)
  end

  def register_dependant_schemas!
    # Since apiCourtsDefinitions.json does not map to the expected directory structure for both the api responses and the model schemas,
    # we are overriding the id, to ensure that the validator can find the definitions without blowing up.
    courts_definitions = JSON.parse(File.open(Rails.root.join("lib/schemas/global/apiCourtsDefinitions.json")).read)
    courts_definitions["id"] = "http://justice.gov.uk/core/courts/external/apiCourtsDefinitions.json"
    JSON::Validator.add_schema(JSON::Schema.new(courts_definitions, Addressable::URI.parse(courts_definitions["id"])))

    defence_organisation = JSON.parse(File.open(Rails.root.join("lib/schemas/global/apiDefenceOrganisation.json")).read)
    defence_organisation["id"] = "http://justice.gov.uk/core/courts/external/apiDefenceOrganisation.json"
    JSON::Validator.add_schema(JSON::Schema.new(defence_organisation, Addressable::URI.parse(defence_organisation["id"])))

    organisation = JSON.parse(File.open(Rails.root.join("lib/schemas/global/apiOrganisation.json")).read)
    organisation["id"] = "http://justice.gov.uk/core/courts/external/apiOrganisation.json"
    JSON::Validator.add_schema(JSON::Schema.new(organisation, Addressable::URI.parse(organisation["id"])))

    address = JSON.parse(File.open(Rails.root.join("lib/schemas/global/apiAddress.json")).read)
    address["id"] = "http://justice.gov.uk/core/courts/external/apiAddress.json"
    JSON::Validator.add_schema(JSON::Schema.new(address, Addressable::URI.parse(address["id"])))

    contact = JSON.parse(File.open(Rails.root.join("lib/schemas/global/apiContactNumber.json")).read)
    contact["id"] = "http://justice.gov.uk/core/courts/external/apiContactNumber.json"
    JSON::Validator.add_schema(JSON::Schema.new(contact, Addressable::URI.parse(contact["id"])))
  end

  def find_reference_holder
    if params[:offenceId]
      Offence.find(params[:offenceId])
    else
      CourtApplication.find(params[:applicationId])
    end
  end
end
