# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LaaReference, type: :model do
  let(:laa_reference) { FactoryBot.create(:laa_reference) }

  let(:json_schema) { :laa_reference }

  subject { laa_reference }

  describe 'validations' do
    it { should validate_presence_of(:applicationReference) }
    it { should validate_presence_of(:statusId) }
    it { should validate_presence_of(:statusCode) }
    it { should validate_presence_of(:statusDescription) }
    it { should validate_presence_of(:statusDate) }
  end

  it_has_behaviour 'conforming to valid schema'
end
