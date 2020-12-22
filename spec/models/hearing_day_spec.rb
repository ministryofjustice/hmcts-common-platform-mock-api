# frozen_string_literal: true

RSpec.describe HearingDay, type: :model do
  subject { hearing_day }

  let(:hearing_day) { FactoryBot.create(:hearing_day) }

  let(:json_schema) { :hearing_day }


  describe "validations" do
    it { is_expected.to validate_presence_of(:sittingDay) }
    it { is_expected.to validate_presence_of(:listedDurationMinutes) }
  end

  describe "relationships" do
    it { is_expected.to have_many(:events).class_name("HearingEvent").dependent(:destroy) }
    it { is_expected.to belong_to(:hearing).optional }
  end

  context "hmcts schema" do
    it_has_behaviour "conforming to valid schema"
  end
end
