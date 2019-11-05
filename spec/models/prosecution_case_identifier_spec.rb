# frozen_string_literal: true

RSpec.describe ProsecutionCaseIdentifier, type: :model do
  let(:prosecution_case_identifier) { FactoryBot.create(:prosecution_case_identifier) }
  let(:json_schema) { :prosecution_case_identifier }

  subject { prosecution_case_identifier }

  describe 'validations' do
    it { should validate_presence_of(:prosecutionAuthorityId) }
    it { should validate_presence_of(:prosecutionAuthorityCode) }
  end

  it_has_a 'realistic factory'

  context 'when caseURN is present' do
    it { should validate_presence_of(:caseURN) }

    it_has_behaviour 'conforming to valid schema'
  end

  context 'when prosecutionAuthorityReference is present' do
    let(:prosecution_case_identifier) { FactoryBot.create(:prosecution_case_identifier_with_reference) }

    it { should validate_presence_of(:prosecutionAuthorityReference) }

    it_has_behaviour 'conforming to valid schema'
  end
end
