require 'rails_helper'

RSpec.describe Ethnicity, type: :model do
  let(:ethnicity) { FactoryBot.create(:ethnicity) }

  it 'matches the given schema' do
    expect(ethnicity.to_builder.target!).to match_json_schema(:ethnicity)
  end
end
