# frozen_string_literal: true

RSpec.describe LinkedDefendant, type: :model do
  subject { linked_defendant }

  let(:linked_defendant) { FactoryBot.create(:linked_defendant) }

  let(:json_schema) { :linked_defendant }


  describe "validations" do
    it { is_expected.to validate_presence_of(:prosecutionCaseId) }
    it { is_expected.to validate_presence_of(:defendantId) }
  end

  it_has_behaviour "conforming to valid schema"

  it_has_a "realistic factory"
end
