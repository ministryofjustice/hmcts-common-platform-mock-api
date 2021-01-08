# frozen_string_literal: true

RSpec.describe CourtApplicationPayment, type: :model do
  subject { court_application_payment }

  let(:court_application_payment) { FactoryBot.create(:court_application_payment) }

  let(:json_schema) { :court_application_payment }

  describe "hmcts schema" do
    it_has_behaviour "conforming to valid schema"
  end
end
