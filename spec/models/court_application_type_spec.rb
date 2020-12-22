# frozen_string_literal: true

RSpec.describe CourtApplicationType, type: :model do
  subject { court_application_type }

  let(:court_application_type) { FactoryBot.create(:court_application_type) }
  let(:json_schema) { :court_application_type }


  describe "validations" do
    it { is_expected.to validate_presence_of(:applicationCategory) }
    it { is_expected.to validate_presence_of(:applicationJurisdictionType) }
    it { is_expected.to validate_presence_of(:applicationType) }
    it { is_expected.to validate_presence_of(:linkType) }

    it do
      is_expected.to validate_inclusion_of(:applicationJurisdictionType)
        .in_array(%w[MAGISTRATES CROWN EITHER])
    end

    it do
      is_expected.to validate_inclusion_of(:applicationSummonsRecipientType)
        .in_array(%w[APPLICANT RESPONDENT])
    end

    it do
      is_expected.to validate_inclusion_of(:applicationSummonsTemplateType)
        .in_array(%w[GENERIC_SUMMONS])
    end

    it do
      is_expected.to validate_inclusion_of(:linkType)
        .in_array(%w[STANDALONE LINKED NEITHER])
    end
  end

  it_has_behaviour "conforming to valid schema"
end
