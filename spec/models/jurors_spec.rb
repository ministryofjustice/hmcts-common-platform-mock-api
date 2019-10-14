require 'rails_helper'

RSpec.describe Jurors, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:numberOfJurors) }
    it { should validate_presence_of(:numberOfSplitJurors) }
    it { should validate_inclusion_of(:unanimous).in_array([true, false]) }
  end

  let(:jurors) { FactoryBot.create(:jurors) }

  it 'matches the given schema' do
    expect(jurors.to_builder.target!).to match_json_schema(:jurors)
  end
end
