# frozen_string_literal: true

RSpec.describe HearingLogFinder do
  let(:params) { ActionController::Parameters.new(params_hash) }

  subject(:find_hearing) { described_class.call(params) }

  context 'with invalid params' do
    let(:params_hash) do
      { random: 'value' }
    end

    it 'raises an invalid params error' do
      expect do
        find_hearing
      end.to raise_error(Errors::InvalidParams)
    end
  end

  context 'when finding by hearingId' do
    let(:hearing) { FactoryBot.create(:hearing) }

    let(:params_hash) do
      { hearingId: hearing.id }
    end

    it { is_expected.to eq(hearing) }

    context 'with an incorrect id' do
      let(:params_hash) do
        { hearingId: '6c0b7068-d4a7-4adc-a7a0-7bd5715b501d' }
      end

      it 'raises a RecordNotFound error' do
        expect do
          find_hearing
        end.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
