require 'rails_helper'

RSpec.describe LaaReference, type: :model do
  describe 'validations' do

    it { should validate_presence_of(:applicationReference) }
    it { should validate_presence_of(:statusId) }
    it { should validate_presence_of(:statusCode) }
    it { should validate_presence_of(:statusDescription) }
    it { should validate_presence_of(:statusDate) }
  end

  let(:laa_reference) { FactoryBot.create(:laa_reference) }

  it 'matches the given schema' do
    expect(laa_reference.to_builder.target!).to match_json_schema(:laa_reference)
  end
end
