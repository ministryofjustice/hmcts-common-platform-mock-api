# frozen_string_literal: true

RSpec.describe ApplicationController, type: :controller do
  describe "handling InvalidParams" do
    controller do
      def index
        raise Errors::InvalidParams
      end
    end

    before { allow(controller).to receive(:authenticate).and_return(true) }

    it "returns http bad_request" do
      get :index
      expect(response).to have_http_status(:bad_request)
    end
  end

  describe "handling ActiveRecord::RecordNotFound" do
    controller do
      def index
        raise ActiveRecord::RecordNotFound
      end
    end

    before { allow(controller).to receive(:authenticate).and_return(true) }

    it "returns http not_found" do
      get :index
      expect(response).to have_http_status(:not_found)
    end
  end

  describe "Authorisation" do
    controller do
      def index
        head :ok
      end
    end

    it "returns unauthorized" do
      get :index
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
