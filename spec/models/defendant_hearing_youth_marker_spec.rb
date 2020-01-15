# frozen_string_literal: true

RSpec.describe DefendantHearingYouthMarker, type: :model do
  let(:defendant_hearing_youth_marker) { FactoryBot.create(:defendant_hearing_youth_marker) }
  let(:json_schema) { :defendant_hearing_youth_marker }

  subject { defendant_hearing_youth_marker }

  describe 'associations' do
    it { should belong_to(:prosecution_case).class_name('ProsecutionCase') }
    it { should belong_to(:defendant).class_name('Defendant') }
    it { should belong_to(:marker).class_name('Marker') }
    it { should belong_to(:hearing).class_name('Hearing') }
  end

  describe 'validations' do
    it { should validate_presence_of(:prosecution_case) }
    it { should validate_presence_of(:defendant) }
    it { should validate_presence_of(:hearing) }
    it { should validate_presence_of(:marker) }
  end

  it_has_behaviour 'conforming to valid schema'
end
