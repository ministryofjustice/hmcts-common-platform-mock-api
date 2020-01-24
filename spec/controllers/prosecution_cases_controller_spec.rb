# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProsecutionCasesController, type: :controller do
  describe 'GET #index' do
    it 'returns unauthorized' do
      get :index, params: { prosecutionCaseReference: 'some reference' }
      expect(response).to be_unauthorized
    end

    context 'with the correct auth header' do
      it 'returns a success response' do
        request.headers['LAASearchCase-Subscription-Key'] = ENV.fetch('SHARED_SECRET_KEY_SEARCH_PROSECUTION_CASE')
        get :index, params: { prosecutionCaseReference: 'some reference' }
        expect(response).to be_successful
      end
    end
  end
end
