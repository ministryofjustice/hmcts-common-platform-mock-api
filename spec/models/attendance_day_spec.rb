# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AttendanceDay, type: :model do
  let(:attendance_day) { FactoryBot.create(:attendance_day) }
  let(:json_schema) { :attendance_day }

  subject { attendance_day }

  describe 'validations' do
    it { should validate_presence_of(:day) }
    it { should validate_inclusion_of(:isInAttendance).in_array([true, false]) }
  end

  it_has_behaviour 'conforming to valid schema'
end
