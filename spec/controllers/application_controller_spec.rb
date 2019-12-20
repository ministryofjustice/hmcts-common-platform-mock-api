# frozen_string_literal: true

require 'rails_helper'

# rubocop:disable Metrics/BlockLength
RSpec.describe ApplicationController, type: :controller do
  include AuthorisedRequestHelper

  describe 'handling InvalidParams' do
    controller do
      def index
        raise Errors::InvalidParams
      end
    end

    before { authorise_requests! }

    it 'returns http bad_request' do
      get :index
      expect(response).to have_http_status(:bad_request)
    end
  end

  describe 'handling ActiveRecord::RecordNotFound' do
    controller do
      def index
        raise ActiveRecord::RecordNotFound
      end
    end

    before { authorise_requests! }

    it 'returns http not_found' do
      get :index
      expect(response).to have_http_status(:not_found)
    end
  end

  describe 'Authorisation' do
    controller do
      def index
        head :ok
      end
    end

    before do
      allow(ENV).to receive(:fetch).with('COMMON_PLATFORM_SHARED_SECRET_KEY').and_return('TOKENTOKEN')
    end

    it_behaves_like 'an unauthorised request'

    describe 'Token Authorisation' do
      before do
        request.headers.merge!('Authorization': "Bearer #{token}")
      end

      describe 'invalid token' do
        let(:token) { 'FAKETOKEN' }
        it_behaves_like 'an unauthorised request'
      end

      describe 'valid token' do
        let(:token) { 'TOKENTOKEN' }

        it 'returns an ok status' do
          get :index
          expect(response).to have_http_status(:ok)
        end
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
