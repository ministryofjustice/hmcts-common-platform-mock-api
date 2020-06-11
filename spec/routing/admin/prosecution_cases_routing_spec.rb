# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Admin::ProsecutionCasesController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/admin/prosecution_cases').to route_to('admin/prosecution_cases#index')
    end

    it 'routes to #new' do
      expect(get: '/admin/prosecution_cases/new').to route_to('admin/prosecution_cases#new')
    end

    it 'routes to #show' do
      expect(get: '/admin/prosecution_cases/1').to route_to('admin/prosecution_cases#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/admin/prosecution_cases/1/edit').to route_to('admin/prosecution_cases#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/admin/prosecution_cases').to route_to('admin/prosecution_cases#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/admin/prosecution_cases/1').to route_to('admin/prosecution_cases#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/admin/prosecution_cases/1').to route_to('admin/prosecution_cases#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/admin/prosecution_cases/1').to route_to('admin/prosecution_cases#destroy', id: '1')
    end
  end
end
