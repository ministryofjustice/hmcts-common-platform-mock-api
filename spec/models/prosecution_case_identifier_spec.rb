# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProsecutionCaseIdentifier, type: :model do
  let(:prosecution_case_identifier) { FactoryBot.create(:prosecution_case_identifier) }
  let(:json_schema) { :prosecution_case_identifier }

  subject { prosecution_case_identifier }

  describe 'validations' do
    it { should validate_presence_of(:prosecutionAuthorityId) }
    it { should validate_presence_of(:prosecutionAuthorityCode) }
  end

  it_has_behaviour 'conforming to valid schema'

end
