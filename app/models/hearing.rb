# frozen_string_literal: true

# rubocop:disable Metrics/ClassLength
class Hearing < ApplicationRecord
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

  # rubocop:disable Metrics/CyclomaticComplexity,Metrics/PerceivedComplexity
  def to_builder
    Jbuilder.new do |hearing|
      hearing.id id
      hearing.jurisdictionType jurisdictionType
      hearing.reportingRestrictionReason reportingRestrictionReason
      hearing.courtCentre court_centre.to_builder
      hearing.hearingLanguage hearingLanguage
      hearing.hasSharedResults hasSharedResults
      hearing.type hearing_type.to_builder
      hearing.applicantCounsels applicant_counsels_builder if applicant_counsels.present?
      hearing.respondentCounsels respondent_counsels_builder if respondent_counsels.present?
      hearing.prosecutionCounsels prosecution_counsels_builder if prosecution_counsels.present?
      hearing.defenceCounsels defence_counsels_builder if defence_counsels.present?
      hearing.applicationPartyCounsels court_application_party_counsels_builder if court_application_party_counsels.present?
      hearing.crackedIneffectiveTrial cracked_ineffective_trial.to_builder if cracked_ineffective_trial.present?
      hearing.isEffectiveTrial isEffectiveTrial
      hearing.isBoxHearing isBoxHearing
      hearing.prosecutionCases Jbuilder.new.array! prosecution_cases_builder if prosecution_cases.present?
      hearing.courtApplications Jbuilder.new.array! court_applications_builder if court_applications.present?
      hearing.defendantReferralReasons Jbuilder.new.array! referral_reasons_builder if referral_reasons.present?
      hearing.hearingCaseNotes Jbuilder.new.array! hearing_case_notes_builder if hearing_case_notes.present?
      hearing.hearingDays Jbuilder.new.array! hearing_days_builder
      hearing.judiciary Jbuilder.new.array! judicial_roles_builder if judicial_roles.present?
      hearing.defendantAttendance Jbuilder.new.array! defendant_attendances_builder if defendant_attendances.present?
      hearing.defendantHearingYouthMarkers Jbuilder.new.array! youth_markers_builder if defendant_hearing_youth_markers.present?
      hearing.courtApplicationPartyAttendance Jbuilder.new.array! party_attendances_builder if court_application_party_attendances.present?
    end
  end
  # rubocop:enable Metrics/CyclomaticComplexity,Metrics/PerceivedComplexity

  private

  def prosecution_cases_builder
    prosecution_cases.map do |prosecution_case|
      prosecution_case.to_builder.attributes!
    end
  end

  def hearing_days_builder
    hearing_days.map do |hearing_day|
      hearing_day.to_builder.attributes!
    end
  end

  def court_applications_builder
    court_applications.map do |court_application|
      court_application.to_builder.attributes!
    end
  end

  def defendant_attendances_builder
    defendant_attendances.map do |defendant_attendance|
      defendant_attendance.to_builder.attributes!
    end
  end

  def referral_reasons_builder
    referral_reasons.map do |referral_reason|
      referral_reason.to_builder.attributes!
    end
  end

  def hearing_case_notes_builder
    hearing_case_notes.map do |hearing_case_note|
      hearing_case_note.to_builder.attributes!
    end
  end

  def judicial_roles_builder
    judicial_roles.map do |judicial_role|
      judicial_role.to_builder.attributes!
    end
  end

  def applicant_counsels_builder
    applicant_counsels.map do |applicant_counsel|
      applicant_counsel.to_builder.attributes!
    end
  end

  def respondent_counsels_builder
    respondent_counsels.map do |respondent_counsel|
      respondent_counsel.to_builder.attributes!
    end
  end

  def prosecution_counsels_builder
    prosecution_counsels.map do |prosecution_counsel|
      prosecution_counsel.to_builder.attributes!
    end
  end

  def defence_counsels_builder
    defence_counsels.map do |defence_counsel|
      defence_counsel.to_builder.attributes!
    end
  end

  def court_application_party_counsels_builder
    court_application_party_counsels.map do |court_application_party_counsel|
      court_application_party_counsel.to_builder.attributes!
    end
  end

  def youth_markers_builder
    defendant_hearing_youth_markers.map do |defendant_hearing_youth_marker|
      defendant_hearing_youth_marker.to_builder.attributes!
    end
  end

  def party_attendances_builder
    court_application_party_attendances.map do |court_application_party_attendance|
      court_application_party_attendance.to_builder.attributes!
    end
  end
end
# rubocop:enable Metrics/ClassLength
