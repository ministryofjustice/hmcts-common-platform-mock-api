# frozen_string_literal: true

RSpec.describe MergedProsecutionCaseTarget, type: :model do
  let(:merged_prosecution_case_target) { FactoryBot.create(:merged_prosecution_case_target) }

  let(:json_schema) { :merged_prosecution_case_target }

  subject { merged_prosecution_case_target }

  describe 'validations' do
    it { should validate_presence_of(:prosecutionCaseId) }
    it { should validate_presence_of(:prosecutionCaseReference) }
  end

  it_has_a 'realistic factory'

  it_has_behaviour 'conforming to valid schema'
end
