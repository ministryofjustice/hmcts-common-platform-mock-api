# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProsecutionCasesController, type: :controller do
  include AuthorisedRequestHelper

  before { authorise_requests! }

  describe 'GET #index' do
    it 'returns a success response' do
      get :index, params: { prosecutionCaseReference: 'some reference' }
      expect(response).to be_successful
    end
  end
end
