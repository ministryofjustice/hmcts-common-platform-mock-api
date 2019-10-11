require 'rails_helper'

RSpec.describe ProsecutionCaseIdentifier, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:prosecutionAuthorityId) }
    it { should validate_presence_of(:prosecutionAuthorityCode) }
  end

  let(:prosecution_case_identifier) { FactoryBot.create(:prosecution_case_identifier) }

  it 'matches the given schema' do
    expect(prosecution_case_identifier.to_builder.target!).to match_json_schema(:prosecution_case_identifier)
  end
end
