# frozen_string_literal: true

FactoryBot.define do
  factory :court_application_type do
    id { SecureRandom.uuid }
    applicationCode { 'MyString' }
    applicationType { 'MyString' }
    applicationTypeWelsh { 'MyString' }
    applicationLegislation { 'MyString' }
    applicationLegislationWelsh { 'MyString' }
    applicationCategory { 'MyString' }
    isAppealApplication { false }
    isBreachApplication { false }
    isApplicationToRecordCourtOfAppealDecision { false }
    linkType { 'LINKED' }
    applicantSynonym { 'MyString' }
    respondentSynonym { 'MyString' }
    applicationJurisdictionType { 'CROWN' }
    applicationSummonsRecipientType { 'APPLICANT' }
    applicationSummonsTemplateType { 'GENERIC_SUMMONS' }
  end
end
