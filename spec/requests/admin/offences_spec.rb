# frozen_string_literal: true

require "rails_helper"

RSpec.describe "offences", type: :request do
  let(:authorisation) { ActionController::HttpAuthentication::Basic.encode_credentials(ENV["ADMIN_USERNAME"], ENV["ADMIN_PASSWORD"]) }
  let(:headers) { { 'Authorization': authorisation } }
  let(:defendant) { FactoryBot.create(:defendant) }

  let(:offence_attributes) do
    FactoryBot.attributes_for(:offence)
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new ProsecutionCase" do
        expect {
          post "/admin/defendants/#{defendant.id}/offences", params: { offence: offence_attributes }, headers: headers
        }.to change(defendant.offences, :count).by(1)
      end
    end
  end
end
