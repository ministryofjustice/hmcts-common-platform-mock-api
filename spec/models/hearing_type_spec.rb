# frozen_string_literal: true

RSpec.describe HearingType, type: :model do
  subject { hearing_type }

  let(:hearing_type) { FactoryBot.create(:hearing_type) }

  let(:json_schema) { :hearing_type }

  it { is_expected.to validate_presence_of(:description) }

  it_has_behaviour "conforming to valid schema"
end
