# frozen_string_literal: true

RSpec.describe HearingSummary, type: :model do
  let(:hearing) { FactoryBot.create(:hearing) }
  let(:hearing_summary) { described_class.new(hearing_id: hearing.id) }

  let(:json_schema) { :hearing_summary }

  subject { hearing_summary }

  it_has_behaviour 'conforming to valid schema'
end
