require 'rails_helper'

RSpec.describe "Admin::Defendants", type: :request do

  let(:defendant) { FactoryBot.create(:defendant) }
  let(:headers) { { 'Authorization': authorisation } }
  let(:authorisation) { ActionController::HttpAuthentication::Basic.encode_credentials(ENV['ADMIN_USERNAME'], ENV['ADMIN_PASSWORD']) }
  let(:invalid_attributes) do
    FactoryBot.attributes_for(:defendant,
                              defendable_type: 'PersonDefendant',
                              defendable_attributes: FactoryBot.attributes_for(:person_defendant,
                                                                               person_attributes: FactoryBot.attributes_for(:person, lastName: nil)))
  end


  describe "GET /show" do
    it "returns http success" do
      get "/admin/defendants/#{defendant.id}", headers: headers
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/admin/defendants/#{defendant.id}/edit", headers: headers
      expect(response).to have_http_status(:success)
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) { FactoryBot.attributes_for(:realistic_defendant) }

      it 'updates the requested defendant' do
        patch admin_defendant_url(defendant), params: { defendant: new_attributes }, headers: headers
        defendant.reload
        expect(defendant).to have_attributes(new_attributes)
      end

      it 'redirects to the defendant' do
        patch admin_defendant_url(defendant), params: { defendant: new_attributes }, headers: headers
        defendant.reload
        expect(response).to redirect_to(admin_defendant_url(defendant))
      end
    end

    context 'with invalid parameters' do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        patch admin_defendant_url(defendant), params: { defendant: invalid_attributes }, headers: headers
        expect(response).to be_successful
      end
    end
  end
end
