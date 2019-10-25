# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HearingDay, type: :model do
  let(:hearing_day) { FactoryBot.create(:hearing_day) }

  let(:json_schema) { :hearing_day }

  subject { hearing_day }

  describe 'validations' do
    it { should validate_presence_of(:sittingDay) }
    it { should validate_presence_of(:listedDurationMinutes) }
  end

  it_has_behaviour 'conforming to valid schema'
end
