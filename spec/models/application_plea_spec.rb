require "rails_helper"

RSpec.describe ApplicationPlea, type: :model do
  subject { application_plea }

  let(:application_plea) { FactoryBot.create(:application_plea) }

  let(:json_schema) { :application_plea }

  describe "associations" do
    it { is_expected.to belong_to(:delegated_powers).class_name("DelegatedPowers") }
    it { is_expected.to belong_to(:lesser_or_alternative_offence).class_name("LesserOrAlternativeOffence") }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:application_id) }
    it { is_expected.to validate_presence_of(:plea_date) }
    it { is_expected.to validate_presence_of(:plea_value) }
  end

  describe "hmcts schema" do
    it_has_behaviour "conforming to valid schema"
  end
end
