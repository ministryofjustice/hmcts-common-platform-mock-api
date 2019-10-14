require 'rails_helper'

RSpec.describe Person, type: :model do
  describe 'associations' do
    it { should belong_to(:ethnicity).class_name('Ethnicity').optional }
    it { should have_one(:address).class_name('Address') }
    it { should have_one(:contact_number).class_name('ContactNumber') }
  end
  describe 'validations' do
    it { should validate_presence_of(:lastName) }
    it { should validate_presence_of(:gender) }
    it do
      should validate_inclusion_of(:title).
        in_array(['MR', 'MRS', 'MISS', 'MS'])
    end

    it do
      should validate_inclusion_of(:gender).
        in_array(['MALE', 'FEMALE', 'NOT_KNOWN', 'NOT_SPECIFIED'])
    end

    it do
      should validate_inclusion_of(:documentationLanguageNeeds).
        in_array(['ENGLISH', 'WELSH'])
    end
  end

  let(:person) { FactoryBot.create(:person) }

  it 'matches the given schema' do
    expect(person.to_builder.target!).to match_json_schema(:person)
  end
end
