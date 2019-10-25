# frozen_string_literal: true

require 'rails_helper'

RSpec.describe JudicialRole, type: :model do
  let(:judicial_role) { FactoryBot.create(:judicial_role) }

  let(:json_schema) { :judicial_role }

  subject { judicial_role }

  describe 'associations' do
    it { should belong_to(:next_hearing).class_name('NextHearing').optional }
  end

  it { should validate_presence_of(:judicialId) }
  it { should validate_presence_of(:judicial_role_type) }

  it_has_behaviour 'conforming to valid schema'

end
