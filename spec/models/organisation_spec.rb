# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Organisation, type: :model do
  let(:organisation) { FactoryBot.create(:organisation) }
  let(:json_schema) { :organisation }

  subject { organisation }

  describe 'associations' do
    it { should belong_to(:address).class_name('Address').optional }
    it { should belong_to(:contact).class_name('ContactNumber').optional }
  end
  describe 'validations' do
    it { should validate_presence_of(:name) }
  end

  it_has_behaviour 'conforming to valid schema'

  context 'with relationships' do
    before do
      organisation.address = FactoryBot.create(:address)
      organisation.contact = FactoryBot.create(:contact_number)
      organisation.save!
    end

    it_has_behaviour 'conforming to valid schema'
  end
end
