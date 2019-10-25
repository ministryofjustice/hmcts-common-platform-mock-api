# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CustodyTimeLimit, type: :model do
  let(:custody_time_limit) { FactoryBot.create(:custody_time_limit) }

  let(:json_schema) { :custody_time_limit }

  subject { custody_time_limit }

  describe 'validations' do
    it { should validate_presence_of(:timeLimit) }
    it { should validate_presence_of(:daysSpent) }
  end

  it_has_behaviour 'conforming to valid schema'
end
