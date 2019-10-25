# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CourtApplicationPartyAttendance, type: :model do
  let(:court_application_party_attendance) { FactoryBot.create(:court_application_party_attendance) }

  let(:json_schema) { :court_application_party_attendance }

  subject { court_application_party_attendance }

  describe 'associations' do
    it { should belong_to(:court_application_party).class_name('CourtApplicationParty') }
    it { should have_many(:attendance_days).class_name('AttendanceDay') }
  end

  describe 'validations' do
    it { should validate_presence_of(:court_application_party) }
    it { should validate_presence_of(:attendance_days) }
  end

  it_has_behaviour 'conforming to valid schema'
end
