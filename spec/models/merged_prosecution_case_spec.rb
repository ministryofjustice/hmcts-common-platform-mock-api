# frozen_string_literal: true

RSpec.describe MergedProsecutionCase, type: :model do
  let(:merged_prosecution_case) { FactoryBot.create(:merged_prosecution_case) }

  let(:json_schema) { :merged_prosecution_case }

  subject { merged_prosecution_case }

  let(:merged_prosecution_case) { FactoryBot.create(:merged_prosecution_case) }

  describe 'associations' do
    it { should have_many(:merged_prosecution_case_targets).class_name('MergedProsecutionCaseTarget') }
  end

  describe 'validations' do
    it { should validate_presence_of(:prosecutionCaseReference) }
    it { should validate_presence_of(:merged_prosecution_case_targets) }

    describe 'merged_prosecution_case_targets' do
      before do
        merged_prosecution_case.merged_prosecution_case_targets = []
        merged_prosecution_case.merged_prosecution_case_targets << FactoryBot.create(:merged_prosecution_case_target)
      end
      subject { merged_prosecution_case }

      context 'when only one is present' do
        it { should_not be_valid }
      end

      context 'when at least two are present' do
        before do
          merged_prosecution_case.merged_prosecution_case_targets << FactoryBot.create(:merged_prosecution_case_target)
        end
        it { should be_valid }
      end
    end
  end

  it_has_behaviour 'conforming to valid schema'
end
