# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LegalEntityDefendant, type: :model do
  describe 'associations' do
    it { should belong_to(:organisation).class_name('Organisation') }
  end
  describe 'validations' do
    it { should validate_presence_of(:organisation) }
  end

  context 'hmcts schema' do
    let(:legal_entity_defendant) { FactoryBot.create(:legal_entity_defendant) }

    it 'matches the given schema' do
      expect(legal_entity_defendant.to_builder.target!).to match_json_schema(:legal_entity_defendant)
    end
  end
end
