# frozen_string_literal: true

RSpec.describe ProsecutionCaseHearingCaseNote, type: :model do
  describe 'associations' do
    it { should belong_to(:hearing_case_note).class_name('HearingCaseNote') }
    it { should belong_to(:prosecution_case).class_name('ProsecutionCase') }
  end
end
