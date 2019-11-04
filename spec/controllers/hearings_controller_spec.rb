# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HearingsController, type: :controller do
  let(:hearing) { FactoryBot.create(:hearing) }
  describe 'GET #show' do
    it 'returns a success response' do
      get :show, params: { hearingId: hearing.id }
      expect(response).to be_successful
    end
  end
end
