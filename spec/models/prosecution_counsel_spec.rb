# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProsecutionCounsel, type: :model do
  let(:prosecution_counsel) { FactoryBot.create(:prosecution_counsel) }
  let(:json_schema) { :prosecution_counsel }

  subject { prosecution_counsel }

  describe 'associations' do
    it { should have_many(:prosecution_cases).class_name('ProsecutionCase') }
    it { should have_many(:attendance_days).class_name('AttendanceDay') }
  end

  describe 'validations' do
    it { should validate_presence_of(:prosecution_cases) }
    it { should validate_presence_of(:attendance_days) }
  end

  it_has_behaviour 'conforming to valid schema'
end