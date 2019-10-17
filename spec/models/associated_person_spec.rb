require 'rails_helper'

RSpec.describe AssociatedPerson, type: :model do
  describe 'associations' do
    it { should belong_to(:person).class_name('Person') }
  end

  describe 'validations' do
    it { should validate_presence_of(:person) }
  end

  let(:associated_person) { FactoryBot.create(:associated_person) }

  it 'matches the given schema' do
    expect(associated_person.to_builder.target!).to match_json_schema(:associated_person)
  end
end
