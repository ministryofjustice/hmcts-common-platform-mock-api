require 'rails_helper'

RSpec.describe NextHearingOffence, type: :model do
  let(:next_hearing_offence) { FactoryBot.create(:next_hearing_offence) }

  it 'matches the given schema' do
    expect(next_hearing_offence.to_builder.target!).to match_json_schema(:next_hearing_offence)
  end
end
