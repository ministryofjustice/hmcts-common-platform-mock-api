# frozen_string_literal: true

RSpec.describe CourtIndicatedSentence, type: :model do
  subject { court_indicated_sentence }

  let(:court_indicated_sentence) { FactoryBot.create(:court_indicated_sentence) }

  let(:json_schema) { :court_indicated_sentence }


  it { is_expected.to validate_presence_of(:courtIndicatedSentenceTypeId) }
  it { is_expected.to validate_presence_of(:courtIndicatedSentenceDescription) }

  it_has_a "realistic factory"

  it_has_behaviour "conforming to valid schema"
end
