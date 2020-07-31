# frozen_string_literal: true

RSpec.describe HearingDay, type: :model do
  let(:hearing_day) { FactoryBot.create(:hearing_day) }

  let(:json_schema) { :hearing_day }

  subject { hearing_day }

  describe 'validations' do
    it { should validate_presence_of(:sittingDay) }
    it { should validate_presence_of(:listedDurationMinutes) }
  end

  describe 'relationships' do
    it { should have_many(:events).class_name('HearingEvent') }
    it { should belong_to(:hearing).optional }
  end

  context 'hmcts schema' do
    it_has_behaviour 'conforming to valid schema'
  end
end
