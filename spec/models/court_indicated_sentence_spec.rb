# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CourtIndicatedSentence, type: :model do
  it { should validate_presence_of(:courtIndicatedSentenceTypeId) }
  it { should validate_presence_of(:courtIndicatedSentenceDescription) }

  let(:court_indicated_sentence) { FactoryBot.create(:court_indicated_sentence) }

  it 'matches the given schema' do
    expect(court_indicated_sentence.to_builder.target!).to match_json_schema(:court_indicated_sentence)
  end
end
