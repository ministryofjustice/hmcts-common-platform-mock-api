# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BoxHearingRequest, type: :model do
  let(:box_hearing_request) { FactoryBot.create(:box_hearing_request) }
  let(:json_schema) { :box_hearing_request }

  subject { box_hearing_request }

  describe 'validations' do
    it { should validate_presence_of(:jurisdictionType) }
    it { should validate_presence_of(:court_centre_id) }
    it { should validate_presence_of(:applicationDueDate) }
    it { should validate_inclusion_of(:jurisdictionType).in_array(%w[CROWN MAGISTRATES]) }
  end

  it_has_behaviour 'conforming to valid schema'
end
