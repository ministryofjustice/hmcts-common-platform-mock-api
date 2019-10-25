# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RespondentCounsel, type: :model do
  let(:respondent_counsel) { FactoryBot.create(:respondent_counsel) }
  let(:json_schema) { :respondent_counsel }

  subject { respondent_counsel }

  describe 'associations' do
    it { should have_many(:court_application_respondents).class_name('CourtApplicationRespondent') }
    it { should have_many(:attendance_days).class_name('AttendanceDay') }
  end

  describe 'validations' do
    it { should validate_presence_of(:court_application_respondents) }
    it { should validate_presence_of(:attendance_days) }
  end

  it_has_behaviour 'conforming to valid schema'
end
