# frozen_string_literal: true

RSpec.describe LesserOrAlternativeOffence, type: :model do
  let(:lesser_or_alternative_offence) { FactoryBot.create(:lesser_or_alternative_offence) }

  let(:json_schema) { :lesser_or_alternative_offence }

  subject { lesser_or_alternative_offence }

  describe 'validations' do
    it { should validate_presence_of(:offenceDefinitionId) }
    it { should validate_presence_of(:offenceCode) }
    it { should validate_length_of(:offenceCode).is_at_most(8) }
    it { should validate_presence_of(:offenceTitle) }
    it { should validate_presence_of(:offenceLegislation) }
  end

  it_has_behaviour 'conforming to valid schema'
  it_has_a 'realistic factory'
end
