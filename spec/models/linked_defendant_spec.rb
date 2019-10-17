require 'rails_helper'

RSpec.describe LinkedDefendant, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:prosecutionCaseId) }
    it { should validate_presence_of(:defendantId) }
  end

  let(:linked_defendant) { FactoryBot.create(:linked_defendant) }

  it 'matches the given schema' do
    expect(linked_defendant.to_builder.target!).to match_json_schema(:linked_defendant)
  end
end
