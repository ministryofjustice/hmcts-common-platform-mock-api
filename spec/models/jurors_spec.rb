# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Jurors, type: :model do
  let(:jurors) { FactoryBot.create(:jurors) }

  let(:json_schema) { :jurors }

  subject { jurors }

  describe 'validations' do
    it { should validate_presence_of(:numberOfJurors) }
    it { should validate_presence_of(:numberOfSplitJurors) }
    it { should validate_inclusion_of(:unanimous).in_array([true, false]) }
  end

  it_has_behaviour 'conforming to valid schema'
end
