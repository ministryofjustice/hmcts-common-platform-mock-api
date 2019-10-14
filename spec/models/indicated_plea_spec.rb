require 'rails_helper'

RSpec.describe IndicatedPlea, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:offenceId) }
    it { should validate_presence_of(:indicatedPleaDate) }
    it { should validate_presence_of(:indicatedPleaValue) }
    it { should validate_presence_of(:source) }
    it do
      should validate_inclusion_of(:indicatedPleaValue).
        in_array(['INDICATED_GUILTY', 'INDICATED_NOT_GUILTY', 'NO_INDICATION'])
    end
    it do
      should validate_inclusion_of(:source).
        in_array(['ONLINE', 'IN_COURT'])
    end
  end

  let(:indicated_plea) { FactoryBot.create(:indicated_plea) }

  it 'matches the given schema' do
    expect(indicated_plea.to_builder.target!).to match_json_schema(:indicated_plea)
  end
end
