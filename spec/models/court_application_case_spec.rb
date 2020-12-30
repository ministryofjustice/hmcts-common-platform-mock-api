# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CourtApplicationCase, type: :model do
  let(:court_application_case) { FactoryBot.create(:court_application_case) }
  let(:json_schema) { :court_application_case }

  subject { court_application_case }

  describe 'associations' do
    it { should belong_to(:prosecution_case).class_name('ProsecutionCase') }
    it { should have_many(:court_application_offences).class_name('CourtApplicationOffence').dependent(:destroy) }
  end

  describe 'validations' do
    it { should validate_presence_of(:prosecution_case) }
  end

  it_has_behaviour 'conforming to valid schema'

  context 'with relationships' do
    before do
      court_application_case.court_application_offences << build(:court_application_offence, court_application_case: nil)
    end

    it_has_behaviour 'conforming to valid schema'
  end
end
