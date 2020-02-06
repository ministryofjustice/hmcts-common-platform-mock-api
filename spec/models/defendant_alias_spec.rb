# frozen_string_literal: true

RSpec.describe DefendantAlias, type: :model do
  let(:defendant_alias) { FactoryBot.create(:defendant_alias) }

  let(:json_schema) { :defendant_alias }

  subject { defendant_alias }

  describe 'validations' do
    it do
      should validate_inclusion_of(:title)
        .in_array(%w[MR MRS MISS MS])
    end
  end

  it_has_behaviour 'conforming to valid schema'
end
