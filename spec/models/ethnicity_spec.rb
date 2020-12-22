# frozen_string_literal: true

RSpec.describe Ethnicity, type: :model do
  subject { ethnicity }

  let(:ethnicity) { FactoryBot.create(:ethnicity) }

  let(:json_schema) { :ethnicity }


  describe "associations" do
    it { is_expected.to have_one(:person).class_name("Person") }
  end

  it_has_a "realistic factory"

  it_has_behaviour "conforming to valid schema"
end
