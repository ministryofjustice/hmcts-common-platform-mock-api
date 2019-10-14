require 'rails_helper'

RSpec.describe LesserOrAlternativeOffence, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:offenceDefinitionId) }
    it { should validate_presence_of(:offenceCode) }
    it { should validate_presence_of(:offenceTitle) }
    it { should validate_presence_of(:offenceLegislation) }
  end

  let(:lesser_or_alternative_offence) { FactoryBot.create(:lesser_or_alternative_offence) }

  it 'matches the given schema' do
    expect(lesser_or_alternative_offence.to_builder.target!).to match_json_schema(:lesser_or_alternative_offence)
  end
end
