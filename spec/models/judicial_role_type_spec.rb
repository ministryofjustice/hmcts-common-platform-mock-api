# frozen_string_literal: true

RSpec.describe JudicialRoleType, type: :model do
  subject { judicial_role_type }

  let(:judicial_role_type) { FactoryBot.create(:judicial_role_type) }
  let(:json_schema) { :judicial_role_type }


  it { is_expected.to validate_presence_of(:judiciaryType) }

  it_has_behaviour "conforming to valid schema"
  it_has_a "realistic factory"
end
