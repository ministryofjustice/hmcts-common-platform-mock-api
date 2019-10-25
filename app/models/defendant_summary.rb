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
      defendant_summary.nationalInsuranceNumber defendant.defendable.person.nationalInsuranceNumber if defendant.person?
      defendant_summary.arrestSummonsNumber defendant.defendable.arrestSummonsNumber if defendant.person?
      defendant_summary.name defendant_name
      defendant_summary.dateOfBirth defendant.defendable.person.dateOfBirth.to_date if defendant.person?
      defendant_summary.dateOfNextHearing date_of_next_hearing
      defendant_summary.proceedingsConcluded proceedings_concluded?
      defendant_summary.offences Jbuilder.new.array! offences_builder
    end
  end

  private

  def date_of_next_hearing
    # This is one of the attributes used to make a search ProsecutionCase request (see prosecutionCaseRequest.json)
    # We will need to use the `dateOfNextHearing` and `name` to search defendants and return to the this object.
    '2012-12-12'
  end

  def proceedings_concluded?
    defendant.offences.map(&:isDisposed).all? true
  end

  def defendant_name
    DefendantName.new(defendant_id: defendant.id).to_builder.attributes!
  end

  def offences_builder
    defendant.offences.map do |offence|
      OffenceSummary.new(offence_id: offence.id).to_builder.attributes!
    end
  end
end
