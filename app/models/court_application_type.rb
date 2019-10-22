# frozen_string_literal: true

class CourtApplicationType < ApplicationRecord
  JURISDICTION_TYPES = %w[MAGISTRATES CROWN EITHER].freeze
  LINK_TYPES = %w[STANDALONE LINKED NEITHER].freeze
  RECIPIENT_TYPES = %w[APPLICANT RESPONDENT].freeze
  TEMPLATE_TYPES = %w[GENERIC_SUMMONS].freeze

  validates :applicationCategory, presence: true
  validates :applicationJurisdictionType, presence: true, inclusion: JURISDICTION_TYPES
  validates :applicationSummonsRecipientType, inclusion: RECIPIENT_TYPES
  validates :applicationSummonsTemplateType, inclusion: TEMPLATE_TYPES
  validates :applicationType, presence: true
  validates :linkType, presence: true, inclusion: LINK_TYPES

  def to_builder
    Jbuilder.new do |court_application_type|
      court_application_type.id id
      court_application_type.applicantSynonym applicantSynonym
      court_application_type.applicationCategory applicationCategory
      court_application_type.applicationCode applicationCode
      court_application_type.applicationJurisdictionType applicationJurisdictionType
      court_application_type.applicationLegislation applicationLegislation
      court_application_type.applicationLegislationWelsh applicationLegislationWelsh
      court_application_type.applicationSummonsRecipientType applicationSummonsRecipientType
      court_application_type.applicationSummonsTemplateType applicationSummonsTemplateType
      court_application_type.applicationType applicationType
      court_application_type.applicationTypeWelsh applicationTypeWelsh
      court_application_type.isAppealApplication isAppealApplication
      court_application_type.isApplicationToRecordCourtOfAppealDecision isApplicationToRecordCourtOfAppealDecision
      court_application_type.isBreachApplication isBreachApplication
      court_application_type.linkType linkType
      court_application_type.respondentSynonym respondentSynonym
    end
  end
end
