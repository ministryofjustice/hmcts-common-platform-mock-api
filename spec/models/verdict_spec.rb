# frozen_string_literal: true

RSpec.describe Verdict, type: :model do
  subject { verdict }

  let(:verdict) { FactoryBot.create(:verdict) }
  let(:json_schema) { :verdict }


  describe "associations" do
    it { is_expected.to belong_to(:verdict_type).class_name("VerdictType") }
    it { is_expected.to belong_to(:jurors).class_name("Jurors").optional }
    it { is_expected.to belong_to(:lesser_or_alternative_offence).class_name("LesserOrAlternativeOffence").optional }
    it { is_expected.to belong_to(:hearing) }
    it { is_expected.to belong_to(:offence) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:verdictDate) }
    it { is_expected.to validate_presence_of(:verdict_type) }
  end

  it_has_behaviour "conforming to valid schema"

  context "with relationships" do
    let(:verdict) { FactoryBot.create(:verdict_with_relationships) }

    it_has_behaviour "conforming to valid schema"
  end

  it_has_a "realistic factory"
end
