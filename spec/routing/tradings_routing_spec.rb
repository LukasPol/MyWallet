require 'rails_helper'

RSpec.describe TradingsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/tradings').to route_to('tradings#index')
    end

    it 'routes to #new' do
      expect(get: '/tradings/new').to route_to('tradings#new')
    end

    it 'routes to #show' do
      expect(get: '/tradings/1').to route_to('tradings#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/tradings/1/edit').to route_to('tradings#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/tradings').to route_to('tradings#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/tradings/1').to route_to('tradings#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/tradings/1').to route_to('tradings#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/tradings/1').to route_to('tradings#destroy', id: '1')
    end
  end
end
