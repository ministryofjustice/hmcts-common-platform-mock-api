# frozen_string_literal: true

RSpec.describe IndicatedPlea, type: :model do
  subject { indicated_plea }

  let(:indicated_plea) { FactoryBot.create(:indicated_plea) }

  let(:json_schema) { :indicated_plea }

  describe "validations" do
    it { is_expected.to validate_presence_of(:indicatedPleaDate) }
    it { is_expected.to validate_presence_of(:indicatedPleaValue) }
    it { is_expected.to validate_presence_of(:source) }

    it do
      is_expected.to validate_inclusion_of(:indicatedPleaValue)
        .in_array(%w[INDICATED_GUILTY INDICATED_NOT_GUILTY NO_INDICATION])
    end

    it do
      is_expected.to validate_inclusion_of(:source)
        .in_array(%w[ONLINE IN_COURT])
    end
  end

  it { is_expected.to belong_to(:offence) }
  it { is_expected.to belong_to(:hearing) }

  it_has_behaviour "conforming to valid schema"

  it_has_a "realistic factory"
end
