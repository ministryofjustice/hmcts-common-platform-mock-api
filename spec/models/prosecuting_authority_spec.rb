# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProsecutingAuthority, type: :model do
  describe 'associations' do
    it { should belong_to(:address).class_name('Address').optional }
    it { should belong_to(:contact).class_name('ContactNumber').optional }
  end

  describe 'validations' do
    it { should validate_presence_of(:prosecutionAuthorityCode) }
  end

  let(:prosecuting_authority) { FactoryBot.create(:prosecuting_authority) }

  it 'matches the given schema' do
    expect(prosecuting_authority.to_builder.target!).to match_json_schema(:prosecuting_authority)
  end
end
