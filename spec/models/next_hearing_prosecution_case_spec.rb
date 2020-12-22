# frozen_string_literal: true

RSpec.describe NextHearingProsecutionCase, type: :model do
  subject { next_hearing_prosecution_case }

  let(:next_hearing_prosecution_case) { FactoryBot.create(:next_hearing_prosecution_case) }

  let(:json_schema) { :next_hearing_prosecution_case }


  describe "associations" do
    it { is_expected.to have_many(:next_hearing_defendants).class_name("NextHearingDefendant") }
    it { is_expected.to belong_to(:next_hearing).class_name("NextHearing").optional }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:next_hearing_defendants) }
  end

  it_has_behaviour "conforming to valid schema"
  it_has_a "realistic factory"
end
