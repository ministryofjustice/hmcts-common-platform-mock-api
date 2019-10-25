# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Address, type: :model do

  let(:address) { FactoryBot.create(:address) }

  let(:json_schema) { :address }

  subject { address }

  describe 'validations' do
    it { should validate_presence_of(:address1) }
  end

  it_has_behaviour 'conforming to valid schema'

end
