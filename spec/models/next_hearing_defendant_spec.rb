# frozen_string_literal: true

RSpec.describe NextHearingDefendant, type: :model do
  subject { next_hearing_defendant }

  let(:next_hearing_defendant) { FactoryBot.create(:next_hearing_defendant) }

  let(:json_schema) { :next_hearing_defendant }


  describe "associations" do
    it { is_expected.to have_many(:next_hearing_offences).class_name("NextHearingOffence") }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:next_hearing_offences) }
  end

  it_has_a "realistic factory"
  it_has_behaviour "conforming to valid schema"
end
