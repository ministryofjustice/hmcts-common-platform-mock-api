# frozen_string_literal: true

RSpec.describe NextHearing, type: :model do
  let(:next_hearing) { FactoryBot.create(:next_hearing) }

  let(:json_schema) { :next_hearing }

  subject { next_hearing }

  describe 'associations' do
    it { should have_many(:judicial_roles).class_name('JudicialRole') }
    it { should have_many(:next_hearing_prosecution_cases).class_name('NextHearingProsecutionCase') }
    it { should have_many(:next_hearing_court_applications).class_name('NextHearingCourtApplication') }
  end
  describe 'validations' do
    it { should validate_presence_of(:hearing_type) }
    it { should validate_presence_of(:court_centre_id) }
    it { should validate_presence_of(:estimatedMinutes) }
    it { should validate_presence_of(:listedStartDateTime) }
    it do
      should validate_inclusion_of(:jurisdictionType)
        .in_array(%w[MAGISTRATES CROWN])
    end
    it do
      should validate_inclusion_of(:hearingLanguage)
        .in_array(%w[ENGLISH WELSH])
    end
  end

  it_has_behaviour 'conforming to valid schema'

  context 'with relationships' do
    before do
      next_hearing.update!(court_centre_id: '6131bd34-33d9-3d1e-8152-8b5a2084f1bd')
    end

    it_has_behaviour 'conforming to valid schema'
  end
end
