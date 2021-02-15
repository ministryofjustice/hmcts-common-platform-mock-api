# frozen_string_literal: true

require "rails_helper"

RSpec.describe "/admin/hearings/:hearing_id/offences/:offence_id/judicial_results", type: :request do
  let(:hearing) { FactoryBot.create(:hearing, :with_prosecution_case) }
  let(:prosecution_case) { hearing.prosecution_cases.first }
  let(:headers) { { 'Authorization': authorisation } }
  let(:authorisation) { ActionController::HttpAuthentication::Basic.encode_credentials(ENV["ADMIN_USERNAME"], ENV["ADMIN_PASSWORD"]) }

  describe "POST /create" do
    let(:offence) { prosecution_case.defendants.first.offences.first }

    context "with valid parameters" do
      it "creates a new Hearing" do
        expect {
          post add_judicial_result_admin_hearing_url(hearing, offence), headers: headers
        }.to change(offence.judicial_results, :count).by(1)
      end

      it "redirects to the prosecution case" do
        post add_judicial_result_admin_hearing_url(hearing, offence), headers: headers
        expect(response).to redirect_to(edit_admin_hearing_url(hearing))
      end
    end
  end
end
