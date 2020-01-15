# frozen_string_literal: true

RSpec.describe HearingType, type: :model do
  let(:hearing_type) { FactoryBot.create(:hearing_type) }

  let(:json_schema) { :hearing_type }

  subject { hearing_type }

  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:code) }

  it_has_behaviour 'conforming to valid schema'
end
