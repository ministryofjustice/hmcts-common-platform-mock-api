# frozen_string_literal: true

require 'rails_helper'

RSpec.describe JudicialRole, type: :model do
  describe 'associations' do
    it { should belong_to(:next_hearing).class_name('NextHearing').optional }
  end

  it { should validate_presence_of(:judicialId) }
  it { should validate_presence_of(:judicial_role_type) }

  let(:judicial_role) { FactoryBot.create(:judicial_role) }

  it 'matches the given schema' do
    expect(judicial_role.to_builder.target!).to match_json_schema(:judicial_role)
  end
end
