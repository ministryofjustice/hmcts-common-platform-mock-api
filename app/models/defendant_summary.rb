# frozen_string_literal: true

class DefendantSummary
  include ActiveModel::Model

  attr_reader :defendant
  attr_accessor :defendant_id

  def initialize(attributes = {})
    super
    @defendant ||= Defendant.find(attributes[:defendant_id])
  end

  def to_builder
    Jbuilder.new do |defendant_summary|
      defendant_summary.defendantId defendant_id
      if defendant.person?
        defendant_summary.defendantNINO defendant.defendable.person.nationalInsuranceNumber
        defendant_summary.defendantASN defendant.defendable.arrestSummonsNumber
        defendant_summary.defendantFirstName defendant_first_name
        defendant_summary.defendantMiddleName defendant_middle_name
        defendant_summary.defendantLastName defendant_last_name
        defendant_summary.defendantDOB defendant.defendable.person.dateOfBirth.to_date
      else
        defendant_summary.defendantName defendant_name
      end

      defendant_summary.dateOfNextHearing date_of_next_hearing
      defendant_summary.proceedingsConcluded proceedings_concluded?
      defendant_summary.offenceSummary offences_builder
    end
  end

private

  def date_of_next_hearing
    # This is one of the attributes used to make a search ProsecutionCase request (see prosecutionCaseRequest.json)
    # We will need to use the `dateOfNextHearing` and `name` to search defendants and return to the this object.
    "2012-12-12"
  end

  def proceedings_concluded?
    defendant.offences.map(&:isDisposed).all? true
  end

  def defendant_name
    defendant.defendable.organisation.name
  end

  def defendant_first_name
    defendant.defendable.person.first_name
  end

  def defendant_middle_name
    defendant.defendable.person.middle_name
  end

  def defendant_last_name
    defendant.defendable.person.last_name
  end

  def offences_builder
    defendant.offences.map do |offence|
      OffenceSummary.new(offence_id: offence.id).to_builder.attributes!
    end
  end
end
