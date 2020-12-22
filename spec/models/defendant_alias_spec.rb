# frozen_string_literal: true

RSpec.describe DefendantAlias, type: :model do
  subject { defendant_alias }

  let(:defendant_alias) { FactoryBot.create(:defendant_alias) }

  let(:json_schema) { :defendant_alias }


  describe "validations" do
    it do
      is_expected.to validate_inclusion_of(:title)
        .in_array(%w[MR MRS MISS MS])
    end
  end

  it_has_behaviour "conforming to valid schema"

  it_has_a "realistic factory"
end
