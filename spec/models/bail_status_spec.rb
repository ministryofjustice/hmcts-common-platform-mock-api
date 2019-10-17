require 'rails_helper'

RSpec.describe BailStatus, type: :model do
  describe 'associations' do
    it { should belong_to(:custody_time_limit).class_name('CustodyTimeLimit').optional }
  end
  describe 'validations' do
    it { should validate_presence_of(:code) }
    it { should validate_presence_of(:description) }
  end

  context 'hmcts schema' do
    let(:bail_status) { FactoryBot.create(:bail_status) }

    before do
      bail_status.update! custody_time_limit: FactoryBot.create(:custody_time_limit)
    end

    it 'matches the given schema' do
      expect(bail_status.to_builder.target!).to match_json_schema(:bail_status)
    end
  end
end
