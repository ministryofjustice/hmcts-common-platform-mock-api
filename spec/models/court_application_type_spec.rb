# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CourtApplicationType, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:applicationCategory) }
    it { should validate_presence_of(:applicationJurisdictionType) }
    it { should validate_presence_of(:applicationType) }
    it { should validate_presence_of(:linkType) }

    it do
      should validate_inclusion_of(:applicationJurisdictionType)
        .in_array(%w[MAGISTRATES CROWN EITHER])
    end

    it do
      should validate_inclusion_of(:applicationSummonsRecipientType)
        .in_array(%w[APPLICANT RESPONDENT])
    end

    it do
      should validate_inclusion_of(:applicationSummonsTemplateType)
        .in_array(%w[GENERIC_SUMMONS])
    end

    it do
      should validate_inclusion_of(:linkType)
        .in_array(%w[STANDALONE LINKED NEITHER])
    end
  end

  let(:court_application_type) { FactoryBot.create(:court_application_type) }

  it 'matches the given schema' do
    expect(court_application_type.to_builder.target!).to match_json_schema(:court_application_type)
  end
end
