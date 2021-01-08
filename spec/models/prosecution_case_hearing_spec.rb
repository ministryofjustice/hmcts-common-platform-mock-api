# frozen_string_literal: true

RSpec.describe ProsecutionCaseHearing, type: :model do
  describe "associations" do
    it { is_expected.to belong_to(:hearing).class_name("Hearing") }
    it { is_expected.to belong_to(:prosecution_case).class_name("ProsecutionCase") }
  end
end
