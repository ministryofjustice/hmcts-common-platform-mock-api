# frozen_string_literal: true

RSpec.describe DefenceCounsel, type: :model do
  subject { defence_counsel }

  let(:defence_counsel) { FactoryBot.create(:defence_counsel) }
  let(:json_schema) { :defence_counsel }

  describe "associations" do
    it { is_expected.to have_many(:defendants).class_name("Defendant").dependent(:nullify) }
    it { is_expected.to have_many(:attendance_days).class_name("AttendanceDay").dependent(:destroy) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:defendants) }
    it { is_expected.to validate_presence_of(:attendance_days) }
  end

  it_has_a "realistic factory"

  it_has_behaviour "conforming to valid schema"
end
