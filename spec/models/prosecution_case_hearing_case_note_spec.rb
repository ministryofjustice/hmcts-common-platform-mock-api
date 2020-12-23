# frozen_string_literal: true

RSpec.describe ProsecutionCaseHearingCaseNote, type: :model do
  describe "associations" do
    it { is_expected.to belong_to(:hearing_case_note).class_name("HearingCaseNote") }
    it { is_expected.to belong_to(:prosecution_case).class_name("ProsecutionCase") }
  end
end
