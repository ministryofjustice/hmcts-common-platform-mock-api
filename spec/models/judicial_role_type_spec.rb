require 'rails_helper'

RSpec.describe JudicialRoleType, type: :model do
  it { should validate_presence_of(:judiciaryType) }

  let(:judicial_role_type) { FactoryBot.create(:judicial_role_type) }

  it 'matches the given schema' do
    expect(judicial_role_type.to_builder.target!).to match_json_schema(:judicial_role_type)
  end

end
