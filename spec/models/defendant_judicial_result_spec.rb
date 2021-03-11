require "rails_helper"

RSpec.describe DefendantJudicialResult, type: :model do
  subject { defendant_judicial_result }

  let(:defendant_judicial_result) { FactoryBot.create(:defendant_judicial_result) }
  let(:json_schema) { :defendant_judicial_result }

  describe "associations" do
    it { is_expected.to belong_to(:judicial_result).class_name("JudicialResult") }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:master_defendant_id) }
    it { is_expected.to validate_presence_of(:judicial_result) }
  end

  it_has_behaviour "conforming to valid schema"
end
