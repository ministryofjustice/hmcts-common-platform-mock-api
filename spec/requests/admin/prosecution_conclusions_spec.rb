# frozen_string_literal: true

require "rails_helper"

RSpec.describe "/admin/prosecution_conclusions", type: :request do
  let(:prosecution_case) { FactoryBot.create(:prosecution_case) }
  let(:headers) { { 'Authorization': authorisation } }
  let(:authorisation) { ActionController::HttpAuthentication::Basic.encode_credentials(ENV["ADMIN_USERNAME"], ENV["ADMIN_PASSWORD"]) }
  let(:type) { "dev" }

  it "calls the ProsecutionCaseConcluder" do
    expect(ProsecutionCaseConcluder).to receive(:call).with(prosecution_case_id: prosecution_case.id, publish_to: type)
    post "/admin/prosecution_conclusions", params: { prosecution_case_id: prosecution_case.id, publish_to: type }, headers: headers
  end
end
