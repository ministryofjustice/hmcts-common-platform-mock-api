# frozen_string_literal: true

require 'rails_helper'

RSpec.describe JudicialRoleType, type: :model do
  let(:judicial_role_type) { FactoryBot.create(:judicial_role_type) }
  let(:json_schema) { :judicial_role_type }

  subject { judicial_role_type }

  it { should validate_presence_of(:judiciaryType) }

  it_has_behaviour 'conforming to valid schema'
end
