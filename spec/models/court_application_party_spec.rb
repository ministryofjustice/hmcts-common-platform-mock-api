# frozen_string_literal: true

RSpec.describe CourtApplicationParty, type: :model do
  let(:court_application_party) { FactoryBot.create(:court_application_party) }

  let(:json_schema) { :court_application_party }

  subject { court_application_party }

  describe 'associations' do
    it { should have_many(:associated_people).class_name('AssociatedPerson') }
    it { should belong_to(:person).class_name('Person').optional }
    it { should belong_to(:organisation).class_name('Organisation').optional }
    it { should belong_to(:prosecuting_authority).class_name('ProsecutingAuthority').optional }
    it { should belong_to(:defendant).class_name('Defendant').optional }
    it { should belong_to(:representation_organisation).class_name('Organisation').optional }
  end

  it_has_behaviour 'conforming to valid schema'

  context 'with relationships' do
    let(:court_application_party) { FactoryBot.create(:court_application_party_with_relationships) }

    it_has_behaviour 'conforming to valid schema'
  end
end
