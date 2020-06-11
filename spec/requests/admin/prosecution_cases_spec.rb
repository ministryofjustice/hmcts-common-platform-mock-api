# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/admin/prosecution_cases', type: :request do
  let(:valid_attributes) do
    FactoryBot.attributes_for(:prosecution_case,
                              prosecution_case_identifier_attributes: FactoryBot.attributes_for(:prosecution_case_identifier),
                              defendants_attributes: [defendants_attributes])
  end

  let(:defendants_attributes) do
    FactoryBot.attributes_for(:defendant,
                              defendable_type: 'PersonDefendant',
                              defendable_attributes: FactoryBot.attributes_for(:person_defendant,
                                                                               person_attributes: FactoryBot.attributes_for(:person)),
                              offences_attributes: [FactoryBot.attributes_for(:offence)])
  end

  let(:invalid_attributes) { FactoryBot.attributes_for(:prosecution_case, initiationCode: nil) }

  let(:prosecution_case) { FactoryBot.create(:prosecution_case) }

  describe 'GET /index' do
    it 'renders a successful response' do
      get admin_prosecution_cases_url
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      get admin_prosecution_case_url(prosecution_case)
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_admin_prosecution_case_url
      expect(response).to be_successful
    end
  end

  describe 'GET /edit' do
    it 'render a successful response' do
      get edit_admin_prosecution_case_url(prosecution_case)
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new ProsecutionCase' do
        expect do
          post admin_prosecution_cases_url, params: { prosecution_case: valid_attributes }
        end.to change(ProsecutionCase, :count).by(1)
      end

      it 'redirects to the created prosecution_case' do
        post admin_prosecution_cases_url, params: { prosecution_case: valid_attributes }
        expect(response).to redirect_to(admin_prosecution_case_url(ProsecutionCase.first))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new ProsecutionCase' do
        expect do
          post admin_prosecution_cases_url, params: { prosecution_case: invalid_attributes }
        end.to change(ProsecutionCase, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post admin_prosecution_cases_url, params: { prosecution_case: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) { FactoryBot.attributes_for(:realistic_prosecution_case) }

      it 'updates the requested prosecution_case' do
        patch admin_prosecution_case_url(prosecution_case), params: { prosecution_case: new_attributes }
        prosecution_case.reload
        expect(prosecution_case).to have_attributes(new_attributes)
      end

      it 'redirects to the prosecution_case' do
        patch admin_prosecution_case_url(prosecution_case), params: { prosecution_case: new_attributes }
        prosecution_case.reload
        expect(response).to redirect_to(admin_prosecution_case_url(prosecution_case))
      end
    end

    context 'with invalid parameters' do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        patch admin_prosecution_case_url(prosecution_case), params: { prosecution_case: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe 'DELETE /destroy' do
    before { prosecution_case.save! }

    it 'destroys the requested prosecution_case' do
      expect do
        delete admin_prosecution_case_url(prosecution_case)
      end.to change(ProsecutionCase, :count).by(-1)
    end

    it 'redirects to the prosecution_cases list' do
      delete admin_prosecution_case_url(prosecution_case)
      expect(response).to redirect_to(admin_prosecution_cases_url)
    end
  end
end
