# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CourtApplicationPartyCounsel, type: :model do
  let(:court_application_party_counsel) { FactoryBot.create(:court_application_party_counsel) }
  let(:json_schema) { :court_application_party_counsel }

  subject { court_application_party_counsel }

  describe 'associations' do
    it { should have_many(:court_application_parties).class_name('CourtApplicationParty') }
    it { should have_many(:attendance_days).class_name('AttendanceDay') }
  end

  describe 'validations' do
    it { should validate_presence_of(:applicationId) }
    it { should validate_presence_of(:attendance_days) }
  end

  it_has_behaviour 'conforming to valid schema'

  context 'with relationships' do
    before do
      court_application_party_counsel.court_application_parties << FactoryBot.create(:court_application_party)
      court_application_party_counsel.save!
    end

    it_has_behaviour 'conforming to valid schema'
  end
end