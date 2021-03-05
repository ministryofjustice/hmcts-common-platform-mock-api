require 'rails_helper'

RSpec.describe ApplicationVerdict, type: :model do
  subject { application_verdict }

  let(:application_verdict) { FactoryBot.create(:application_verdict) }

  let(:json_schema) { :application_verdict }

  describe "associations" do
    it { is_expected.to belong_to(:verdict_type).class_name("VerdictType") }
    it { is_expected.to belong_to(:jurors).class_name("Jurors") }
    it { is_expected.to belong_to(:lesser_or_alternative_offence).class_name("LesserOrAlternativeOffence") }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:application_id) }
    it { is_expected.to validate_presence_of(:verdict_date) }
    it { is_expected.to validate_presence_of(:verdict_type) }
  end

  it_has_behaviour "conforming to valid schema"

  it_has_a "realistic factory"
end
