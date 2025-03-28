require "rails_helper"

RSpec.describe "/admin/application_conclusions/:id", type: :request do
  let(:court_application) { FactoryBot.create(:court_application) }
  let(:headers) { { 'Authorization': authorisation } }
  let(:authorisation) { ActionController::HttpAuthentication::Basic.encode_credentials(ENV["ADMIN_USERNAME"], ENV["ADMIN_PASSWORD"]) }
  let(:type) { "dev" }

  it "calls the CourtApplicationConcluder" do
    expect(CourtApplicationConcluder).to receive(:call).with(court_application_id: court_application.id, publish_to: type)
    post "/admin/application_conclusions/#{court_application.id}/#{type}", headers:
  end
end
