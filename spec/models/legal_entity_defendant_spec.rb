# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LegalEntityDefendant, type: :model do
  let(:legal_entity_defendant) { FactoryBot.create(:legal_entity_defendant) }

  let(:json_schema) { :legal_entity_defendant }

  subject { legal_entity_defendant }

  describe 'associations' do
    it { should belong_to(:organisation).class_name('Organisation') }
  end
  describe 'validations' do
    it { should validate_presence_of(:organisation) }
  end

  context 'hmcts schema' do
    it_has_behaviour 'conforming to valid schema'
  end
end
