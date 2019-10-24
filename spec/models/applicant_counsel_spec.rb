# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicantCounsel, type: :model do
  let(:applicant_counsel) { FactoryBot.create(:applicant_counsel) }
  let(:json_schema) { :applicant_counsel }

  subject { applicant_counsel }

  describe 'associations' do
    it { should have_many(:applicants).class_name('Applicant') }
    it { should have_many(:attendance_days).class_name('AttendanceDay') }
  end

  describe 'validations' do
    it { should validate_presence_of(:applicants) }
    it { should validate_presence_of(:attendance_days) }
  end

  it_has_behaviour 'conforming to valid schema'
end
