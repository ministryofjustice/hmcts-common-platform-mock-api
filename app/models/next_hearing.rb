class NextHearing < ApplicationRecord
  belongs_to :hearing_type
  belongs_to :court_centre

  has_many :judicial_roles
  has_many :next_hearing_prosecution_cases
  has_many :next_hearing_court_applications

  validates :hearing_type, presence: true
  validates :court_centre, presence: true
  validates :estimatedMinutes, presence: true
  validates :listedStartDateTime, presence: true
  validates :jurisdictionType, inclusion: %w(MAGISTRATES CROWN)
  validates :hearingLanguage, inclusion: %w(ENGLISH WELSH)

  def to_builder
    Jbuilder.new do |next_hearing|
      next_hearing.type hearing_type.to_builder
      next_hearing.courtCentre court_centre.to_builder
      next_hearing.estimatedMinutes estimatedMinutes
      next_hearing.listedStartDateTime listedStartDateTime
      next_hearing.judiciary Jbuilder.new.array! judicial_roles_builder
      next_hearing.nextHearingProsecutionCases Jbuilder.new.array! next_hearing_prosecution_cases_builder
      next_hearing.nextHearingCourtApplicationId Jbuilder.new.array! next_hearing_court_applications_builder
    end
  end

  private
    def judicial_roles_builder
      judicial_roles.map do |judicial_role|
        judicial_role.to_builder.attributes!
      end
    end

    def next_hearing_prosecution_cases_builder
      next_hearing_prosecution_cases.map do |next_hearing_prosecution_case|
        next_hearing_prosecution_case.to_builder.attributes!
      end
    end

    def next_hearing_court_applications_builder
      next_hearing_court_applications.ids
    end
end
