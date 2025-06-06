# frozen_string_literal: true

class CourtApplicationDefendantSummary
  include ActiveModel::Model

  attr_reader :defendant
  attr_accessor :defendant_id

  def initialize(attributes = {})
    super
    @defendant ||= Defendant.find(attributes[:defendant_id])
  end

  def to_builder
    Jbuilder.new do |defendant_summary|
      if defendant.person?
        defendant_summary.defendantNINO defendant.defendable.person.nationalInsuranceNumber
        defendant_summary.defendantASN defendant.defendable.arrestSummonsNumber
        defendant_summary.defendantFirstName defendant_first_name
        defendant_summary.defendantMiddleName defendant_middle_name
        defendant_summary.defendantLastName defendant_last_name
        defendant_summary.defendantDOB defendant.defendable.person.dateOfBirth.to_date
      else
        defendant_summary.defendantName defendant_organisation_name
      end
      defendant_summary.dateOfNextHearing date_of_next_hearing
      defendant_summary.proceedingsConcluded proceedings_concluded?
      defendant_summary.masterDefendantId defendant.masterDefendantId
      defendant_summary.subjectId defendant_id
      defendant_summary.offenceSummary offence_summary
    end
  end

  def date_of_next_hearing
    defendant.judicial_results.order(created_at: :asc).last&.next_hearing&.listedStartDateTime
  end

private

  def proceedings_concluded?
    defendant.offences.all?(&:isDisposed)
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

  def defendant_organisation_name
    defendant.defendable.organisation.name
  end

  def offence_summary
    defendant.offences.map { |offence| OffenceSummary.new(offence_id: offence.id).to_builder.attributes! }
  end
end
