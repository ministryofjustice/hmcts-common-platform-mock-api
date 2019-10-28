# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CourtApplicationParty, type: :model do
  let(:court_application_party) { FactoryBot.create(:court_application_party) }

  let(:json_schema) { :court_application_party }

  subject { court_application_party }

  describe 'associations' do
    it { should have_many(:associated_people).class_name('AssociatedPerson') }
    it { should belong_to(:person).class_name('Person') }
    it { should belong_to(:organisation).class_name('Organisation') }
    it { should belong_to(:prosecuting_authority).class_name('ProsecutingAuthority') }
    it { should belong_to(:defendant).class_name('Defendant') }
    it { should belong_to(:representation_organisation).class_name('Organisation') }
  end

  it_has_behaviour 'conforming to valid schema'

  context 'with relationships' do
    before do
      court_application_party.person = FactoryBot.create(:person)
      court_application_party.organisation = FactoryBot.create(:organisation)
      court_application_party.prosecuting_authority = FactoryBot.create(:prosecuting_authority)
      court_application_party.save!
    end
    it_has_behaviour 'conforming to valid schema'
  end
end
