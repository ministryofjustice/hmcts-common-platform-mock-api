# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CourtApplicationOffence, type: :model do
  let(:court_application_offence) { FactoryBot.create(:court_application_offence) }
  let(:json_schema) { :court_application_offence }

  subject { court_application_offence }

  describe 'associations' do
    it { should belong_to(:court_application_case).class_name('CourtApplicationCase') }
    it { should belong_to(:offence).class_name('Offence') }
  end

  describe 'validations' do
    it { should validate_presence_of(:offence) }
  end

  it_has_behaviour 'conforming to valid schema'
end
