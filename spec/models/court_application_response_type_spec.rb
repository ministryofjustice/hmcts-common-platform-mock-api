# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CourtApplicationResponseType, type: :model do
  let(:court_application_response_type) { FactoryBot.create(:court_application_response_type) }

  let(:json_schema) { :court_application_response_type }

  subject { court_application_response_type }

  describe 'validations' do
    it { should validate_presence_of(:description) }
    it { should validate_numericality_of(:sequence).is_greater_than(0) }
  end

  context 'hmcts schema' do
    it_has_behaviour 'conforming to valid schema'
  end
end
