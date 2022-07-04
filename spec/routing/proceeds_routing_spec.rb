require 'rails_helper'

RSpec.describe ProceedsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/proceeds').to route_to('proceeds#index')
    end

    it 'routes to #new' do
      expect(get: '/proceeds/new').to route_to('proceeds#new')
    end

    it 'routes to #show' do
      expect(get: '/proceeds/1').to route_to('proceeds#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/proceeds/1/edit').to route_to('proceeds#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/proceeds').to route_to('proceeds#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/proceeds/1').to route_to('proceeds#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/proceeds/1').to route_to('proceeds#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/proceeds/1').to route_to('proceeds#destroy', id: '1')
    end
  end
end
