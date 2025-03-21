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
      it "creates a new defendant offence" do
        expect {
          post "/admin/defendants/#{defendant.id}/offences", params: { offence: offence_attributes }, headers:
        }.to change(defendant.offences, :count).by(1)
      end
    end

    context "with invalid parameters" do
      it "does not create a new defendant offence" do
        expect {
          post "/admin/defendants/#{defendant.id}/offences", params: { offence: offence_attributes.merge(offenceCode: nil) }, headers:
        }.not_to change(defendant.offences, :count)
      end
    end
  end
end
