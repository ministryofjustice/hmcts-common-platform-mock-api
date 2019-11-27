# frozen_string_literal: true

class Hearing < ApplicationRecord
  include BuilderMappable
  belongs_to :court_centre
  belongs_to :hearing_type
  belongs_to :cracked_ineffective_trial, optional: true
  has_many :prosecution_cases
  has_many :court_applications
  has_many :referral_reasons
  has_many :hearing_case_notes
  has_many :hearing_days
  has_many :judicial_roles
  has_many :applicant_counsels
  has_many :respondent_counsels
  has_many :prosecution_counsels
  has_many :defence_counsels
  has_many :court_application_party_counsels
  has_many :defendant_attendances
  has_many :court_application_party_attendances
  has_many :defendant_hearing_youth_markers

  validates :jurisdictionType, presence: true, inclusion: %w[MAGISTRATES CROWN]
  validates :court_centre, presence: true
  validates :hearing_type, presence: true
  validates :hearing_days, presence: true
  validates :hearingLanguage, inclusion: %w[ENGLISH WELSH]
  def to_builder
    Jbuilder.new do |hearing|
      hearing.id id
      hearing.jurisdictionType jurisdictionType
      hearing.reportingRestrictionReason reportingRestrictionReason
      hearing.courtCentre court_centre.to_builder
      hearing.hearingLanguage hearingLanguage
      hearing.hasSharedResults hasSharedResults
      hearing.type hearing_type.to_builder
      hearing.applicantCounsels array_builder(applicant_counsels)
      hearing.respondentCounsels array_builder(respondent_counsels)
      hearing.prosecutionCounsels array_builder(prosecution_counsels)
      hearing.defenceCounsels array_builder(defence_counsels)
      hearing.applicationPartyCounsels array_builder(court_application_party_counsels)
      hearing.crackedIneffectiveTrial cracked_ineffective_trial.to_builder if cracked_ineffective_trial.present?
      hearing.isEffectiveTrial isEffectiveTrial
      hearing.isBoxHearing isBoxHearing
      hearing.prosecutionCases array_builder(prosecution_cases)
      hearing.courtApplications array_builder(court_applications)
      hearing.defendantReferralReasons array_builder(referral_reasons)
      hearing.hearingCaseNotes array_builder(hearing_case_notes)
      hearing.hearingDays array_builder(hearing_days)
      hearing.judiciary array_builder(judicial_roles)
      hearing.defendantAttendance array_builder(defendant_attendances)
      hearing.defendantHearingYouthMarkers array_builder(defendant_hearing_youth_markers)
      hearing.courtApplicationPartyAttendance array_builder(court_application_party_attendances)
    end
  end
end
