# frozen_string_literal: true

RSpec.describe HearingsController, type: :controller do
  let(:hearing) { FactoryBot.create(:hearing) }

  describe "GET #show" do
    context "without authorization" do
      it "returns unauthorized" do
        get :show, params: { hearingId: hearing.hearing_id }
        expect(response).to be_unauthorized
      end
    end

    context "with the correct auth header and the hearing exists" do
      it "returns a success response" do
        request.headers["Ocp-Apim-Subscription-Key"] = ENV.fetch("SHARED_SECRET_KEY")
        get :show, params: { hearingId: hearing.hearing_id }
        expect(response).to be_successful
      end

      context "when hearing is resulted" do
        before { hearing.update!(resulted: true) }

        it "returns a success response" do
          request.headers["Ocp-Apim-Subscription-Key"] = ENV.fetch("SHARED_SECRET_KEY")
          get :show, params: { hearingId: hearing.hearing_id }
          expect(response.body).to include(hearing.hearing_id)
        end
      end
    end

    context "when the hearing does not exist" do
      it "returns a success response" do
        request.headers["Ocp-Apim-Subscription-Key"] = ENV.fetch("SHARED_SECRET_KEY")
        get :show, params: { hearingId: "c748bfa0-925a-450b-b4d5-a031c0ee3440" }
        expect(response).to be_successful
      end
    end
  end

  describe "GET #log" do
    let(:hearing_day) { hearing.hearing_days.first }

    before { FactoryBot.create(:hearing_event, hearing_day: hearing_day) }

    it "returns unauthorized" do
      get :log, params: { hearingId: hearing.id, date: "2019-10-23" }
      expect(response).to be_unauthorized
    end

    context "with the correct auth header" do
      it "returns a success response" do
        request.headers["Ocp-Apim-Subscription-Key"] = ENV.fetch("SHARED_SECRET_KEY")
        get :log, params: { hearingId: hearing.id, date: "2019-10-23" }
        expect(response).to be_successful
      end
    end
  end
end
