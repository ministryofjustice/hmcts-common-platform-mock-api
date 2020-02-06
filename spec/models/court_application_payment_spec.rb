# frozen_string_literal: true

RSpec.describe CourtApplicationPayment, type: :model do
  let(:court_application_payment) { FactoryBot.create(:court_application_payment) }

  let(:json_schema) { :court_application_payment }

  subject { court_application_payment }

  describe 'validations' do
    it { should validate_inclusion_of(:isFeePaid).in_array([true, false]) }
    it { should validate_inclusion_of(:isFeeExempt).in_array([true, false]) }
    it { should validate_inclusion_of(:isFeeUndertakingAttached).in_array([true, false]) }
  end

  context 'hmcts schema' do
    it_has_behaviour 'conforming to valid schema'
  end
end
