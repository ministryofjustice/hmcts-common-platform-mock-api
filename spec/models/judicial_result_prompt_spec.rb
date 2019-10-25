# frozen_string_literal: true

require 'rails_helper'

RSpec.describe JudicialResultPrompt, type: :model do
  let(:judicial_result_prompt) { FactoryBot.create(:judicial_result_prompt) }

  let(:json_schema) { :judicial_result_prompt }

  subject { judicial_result_prompt }

  describe 'associations' do
    it { should have_many(:user_groups).class_name('UserGroup') }
    it { should belong_to(:judicial_result).class_name('JudicialResult').optional }
  end
  describe 'validations' do
    it { should validate_presence_of(:label) }
    it { should validate_inclusion_of(:isAvailableForCourtExtract).in_array([true, false]) }
  end

  it_has_behaviour 'conforming to valid schema'

end
