# frozen_string_literal: true

RSpec.describe AttendanceDay, type: :model do
  let(:attendance_day) { FactoryBot.create(:attendance_day) }
  let(:json_schema) { :attendance_day }

  subject { attendance_day }

  describe 'validations' do
    it { should validate_presence_of(:day) }
  end

  it_has_a 'realistic factory'

  it_has_behaviour 'conforming to valid schema'
end
