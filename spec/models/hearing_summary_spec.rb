# frozen_string_literal: true

RSpec.describe HearingSummary, type: :model do
  subject { hearing_summary }

  let(:hearing) { FactoryBot.create(:hearing) }
  let(:hearing_summary) { described_class.new(hearing_id: hearing.hearing_id, sitting_day: hearing.sitting_day) }

  let(:json_schema) { :hearing_summary }

  it_has_behaviour "conforming to valid schema"
end
