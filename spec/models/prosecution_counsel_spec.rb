# frozen_string_literal: true

RSpec.describe ProsecutionCounsel, type: :model do
  subject { prosecution_counsel }

  let(:prosecution_counsel) { FactoryBot.create(:prosecution_counsel) }
  let(:json_schema) { :prosecution_counsel }


  describe "associations" do
    it { is_expected.to have_many(:prosecution_cases).class_name("ProsecutionCase").dependent(:nullify) }
    it { is_expected.to have_many(:attendance_days).class_name("AttendanceDay").dependent(:destroy) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:prosecution_cases) }
    it { is_expected.to validate_presence_of(:attendance_days) }
  end

  it_has_behaviour "conforming to valid schema"
end
