# frozen_string_literal: true

RSpec.describe AssociatedPerson, type: :model do
  let(:associated_person) { FactoryBot.create(:associated_person) }

  let(:json_schema) { :associated_person }

  subject { associated_person }

  describe 'associations' do
    it { should belong_to(:person).class_name('Person') }
  end

  describe 'validations' do
    it { should validate_presence_of(:person) }
  end

  it_has_behaviour 'conforming to valid schema'
end
