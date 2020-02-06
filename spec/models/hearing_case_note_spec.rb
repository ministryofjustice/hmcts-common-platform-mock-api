# frozen_string_literal: true

RSpec.describe HearingCaseNote, type: :model do
  let(:hearing_case_note) { FactoryBot.create(:hearing_case_note) }
  let(:json_schema) { :hearing_case_note }

  subject { hearing_case_note }

  describe 'associations' do
    it { should belong_to(:hearing).class_name('Hearing') }
    it { should belong_to(:court_clerk).class_name('DelegatedPowers') }
    it { should have_many(:prosecution_cases).class_name('ProsecutionCase') }
    it { should have_many(:prosecution_case_hearing_case_notes).class_name('ProsecutionCaseHearingCaseNote') }
  end

  describe 'validations' do
    it { should validate_presence_of(:hearing) }
    it { should validate_presence_of(:prosecution_cases) }
    it { should validate_presence_of(:noteDateTime) }
    it { should validate_presence_of(:noteType) }
    it { should validate_inclusion_of(:noteType).in_array(%w[HMCTS LEGAL]) }
    it { should validate_presence_of(:note) }
    it { should validate_presence_of(:court_clerk) }
  end

  it_has_behaviour 'conforming to valid schema'
end
