require "rails_helper"

RSpec.describe CourtOrderSubject, type: :model do
  subject { court_order_subject }

  let(:court_order_subject) { FactoryBot.create(:court_order_subject) }

  let(:json_schema) { :court_order_subject }

  describe "validations" do
    it { is_expected.to validate_presence_of(:master_defendant_id) }
  end

  it_has_behaviour "conforming to valid schema"

  it_has_a "realistic factory"
end
