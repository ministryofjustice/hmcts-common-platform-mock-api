# frozen_string_literal: true

RSpec.describe LesserOrAlternativeOffence, type: :model do
  subject { lesser_or_alternative_offence }

  let(:lesser_or_alternative_offence) { FactoryBot.create(:lesser_or_alternative_offence) }

  let(:json_schema) { :lesser_or_alternative_offence }


  describe "validations" do
    it { is_expected.to validate_presence_of(:offenceDefinitionId) }
    it { is_expected.to validate_presence_of(:offenceCode) }
    it { is_expected.to validate_length_of(:offenceCode).is_at_most(8) }
    it { is_expected.to validate_presence_of(:offenceTitle) }
    it { is_expected.to validate_presence_of(:offenceLegislation) }
  end

  it_has_behaviour "conforming to valid schema"
  it_has_a "realistic factory"
end
