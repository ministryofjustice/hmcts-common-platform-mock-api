# frozen_string_literal: true

RSpec.describe HearingsController, type: :controller do
  let(:hearing) { FactoryBot.create(:hearing) }

  describe 'GET #show' do
    it 'returns unauthorized' do
      get :show, params: { hearingId: hearing.id }
      expect(response).to be_unauthorized
    end

    context 'with the correct auth header' do
      it 'returns a success response' do
        request.headers['Ocp-Apim-Subscription-Key'] = ENV.fetch('SHARED_SECRET_KEY')
        get :show, params: { hearingId: hearing.id }
        expect(response).to be_successful
      end
    end
  end

  describe 'GET #log' do
    it 'returns unauthorized' do
      get :log, params: { hearingId: hearing.id }
      expect(response).to be_unauthorized
    end

    context 'with the correct auth header' do
      it 'returns a success response' do
        request.headers['Ocp-Apim-Subscription-Key'] = ENV.fetch('SHARED_SECRET_KEY')
        get :log, params: { hearingId: hearing.id }
        expect(response).to be_successful
      end
    end
  end
end
