# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DelegatedPowers, type: :model do
  let(:delegated_powers) { FactoryBot.create(:delegated_powers) }

  let(:json_schema) { :delegated_powers }

  subject { delegated_powers }

  it { should validate_presence_of(:userId) }
  it { should validate_presence_of(:firstName) }
  it { should validate_presence_of(:lastName) }

  it_has_behaviour 'conforming to valid schema'
end
