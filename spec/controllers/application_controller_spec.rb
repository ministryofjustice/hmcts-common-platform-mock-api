# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  describe 'handling InvalidParams' do
    controller do
      def index
        raise Errors::InvalidParams
      end
    end

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

    it 'returns http not_found' do
      get :index
      expect(response).to have_http_status(:not_found)
    end
  end
end
