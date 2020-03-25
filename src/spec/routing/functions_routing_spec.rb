require 'rails_helper'

RSpec.describe FunctionsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/functions').to route_to('functions#index')
    end

    it 'routes to #new' do
      expect(get: '/functions/new').to route_to('functions#new')
    end

    it 'routes to #show' do
      expect(get: '/functions/1').to route_to('functions#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/functions/1/edit').to route_to('functions#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/functions').to route_to('functions#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/functions/1').to route_to('functions#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/functions/1').to route_to('functions#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/functions/1').to route_to('functions#destroy', id: '1')
    end
  end
end
