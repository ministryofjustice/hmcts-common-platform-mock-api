require 'rails_helper'

RSpec.describe HearingType, type: :model do
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:code) }

  let(:hearing_type) { FactoryBot.create(:hearing_type) }

  it 'matches the given schema' do
    expect(hearing_type.to_builder.target!).to match_json_schema(:hearing_type)
  end
end
