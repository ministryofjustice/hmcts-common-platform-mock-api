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
        defendant_summary.defendantName defendant_person_name
        defendant_summary.defendantDOB defendant.defendable.person.dateOfBirth.to_date
      else
        defendant_summary.defendantName defendant_organisation_name
      end

      defendant_summary.dateOfNextHearing date_of_next_hearing
      defendant_summary.proceedingsConcluded proceedings_concluded?
      defendant_summary.offenceSummary offences_builder
    end
  end

  def date_of_next_hearing
    defendant.judicial_results.order(created_at: :asc).last&.next_hearing&.listedStartDateTime
  end

private

  def proceedings_concluded?
    defendant.offences.map(&:isDisposed).all? true
  end

  def defendant_first_name
    defendant.defendable.person.first_name
  end

  def defendant_last_name
    defendant.defendable.person.last_name
  end

  def defendant_organisation_name
    defendant.defendable.organisation.name
  end

  def defendant_person_name
    defendant_first_name + defendant_last_name
  end

  def offences_builder
    defendant.offences.map do |offence|
      OffenceSummary.new(offence_id: offence.id).to_builder.attributes!
    end
  end
end
