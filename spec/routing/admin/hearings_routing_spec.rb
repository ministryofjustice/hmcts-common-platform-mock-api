# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Admin::HearingsController, type: :routing do
  describe 'routing' do
    it 'routes to #new' do
      expect(get: '/admin/prosecution_cases/case-id/hearings/new')
        .to route_to('admin/hearings#new', prosecution_case_id: 'case-id')
    end

    it 'routes to #show' do
      expect(get: '/admin/hearings/1')
        .to route_to('admin/hearings#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/admin/hearings/1/edit')
        .to route_to('admin/hearings#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/admin/prosecution_cases/case-id/hearings').to route_to(
        'admin/hearings#create', prosecution_case_id: 'case-id'
      )
    end

    it 'routes to #update via PUT' do
      expect(put: '/admin/hearings/1')
        .to route_to('admin/hearings#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/admin/hearings/1')
        .to route_to('admin/hearings#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/admin/hearings/1')
        .to route_to('admin/hearings#destroy', id: '1')
    end
  end
end
