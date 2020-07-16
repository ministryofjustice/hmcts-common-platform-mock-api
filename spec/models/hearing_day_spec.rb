# frozen_string_literal: true

RSpec.describe HearingDay, type: :model do
  let(:hearing_day) { FactoryBot.create(:hearing_day) }

  let(:json_schema) { :hearing_day }

  subject { hearing_day }

  describe 'validations' do
    it { should validate_presence_of(:sittingDay) }
    it { should validate_presence_of(:listedDurationMinutes) }

    context 'when startTime is after endTime' do
      before do
        hearing_day.startTime = '10:00'
        hearing_day.endTime = '09:00'
      end

      it { is_expected.not_to be_valid }
    end
  end

  describe 'relationships' do
    it { should have_many(:judicial_roles) }
  end

  context 'hmcts schema' do
    it_has_behaviour 'conforming to valid schema'

    context 'with relationships' do
      let(:hearing_day) { FactoryBot.create(:hearing_day_with_relationships) }

      it_has_behaviour 'conforming to valid schema'
    end
  end
end
