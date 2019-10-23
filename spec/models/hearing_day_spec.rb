# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HearingDay, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:sittingDay) }
    it { should validate_presence_of(:listedDurationMinutes) }
  end

  let(:hearing_day) { FactoryBot.create(:hearing_day) }

  it 'matches the given schema' do
    expect(hearing_day.to_builder.target!).to match_json_schema(:hearing_day)
  end
end
