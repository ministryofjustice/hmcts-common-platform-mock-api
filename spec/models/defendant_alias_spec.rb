# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DefendantAlias, type: :model do
  describe 'validations' do
    it do
      should validate_inclusion_of(:title)
        .in_array(%w[MR MRS MISS MS])
    end
  end

  let(:defendant_alias) { FactoryBot.create(:defendant_alias) }

  it 'matches the given schema' do
    expect(defendant_alias.to_builder.target!).to match_json_schema(:defendant_alias)
  end
end
