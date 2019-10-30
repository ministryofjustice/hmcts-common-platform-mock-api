# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProsecutingAuthority, type: :model do
  let(:prosecuting_authority) { FactoryBot.create(:prosecuting_authority) }

  let(:json_schema) { :prosecuting_authority }

  subject { prosecuting_authority }

  describe 'associations' do
    it { should belong_to(:address).class_name('Address').optional }
    it { should belong_to(:contact).class_name('ContactNumber').optional }
  end

  describe 'validations' do
    it { should validate_presence_of(:prosecutionAuthorityCode) }
  end

  it_has_behaviour 'conforming to valid schema'

  context 'with relationships' do
    before do
      prosecuting_authority.contact = FactoryBot.create(:contact_number)
      prosecuting_authority.address = FactoryBot.create(:address)
      prosecuting_authority.save!
    end

    it_has_behaviour 'conforming to valid schema'
  end
end
