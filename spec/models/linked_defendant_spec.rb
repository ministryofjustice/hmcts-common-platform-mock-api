# frozen_string_literal: true

RSpec.describe LinkedDefendant, type: :model do
  let(:linked_defendant) { FactoryBot.create(:linked_defendant) }

  let(:json_schema) { :linked_defendant }

  subject { linked_defendant }

  describe 'validations' do
    it { should validate_presence_of(:prosecutionCaseId) }
    it { should validate_presence_of(:defendantId) }
  end

  it_has_behaviour 'conforming to valid schema'
end
