require 'rails_helper'

RSpec.describe FunctionsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/users/user-name/functions').to route_to('functions#index', user_id: 'user-name')
    end

    it 'routes to #new' do
      expect(get: '/users/user-name/functions/new').to route_to('functions#new', user_id: 'user-name')
    end

    it 'routes to #show' do
      expect(get: '/users/user-name/functions/1').to route_to('functions#show', id: '1', user_id: 'user-name')
    end

    it 'routes to #edit' do
      expect(get: '/users/user-name/functions/1/edit').to route_to('functions#edit', id: '1', user_id: 'user-name')
    end

    it 'routes to #create' do
      expect(post: '/users/user-name/functions').to route_to('functions#create', user_id: 'user-name')
    end

    it 'routes to #update via PUT' do
      expect(put: '/users/user-name/functions/1').to route_to('functions#update', id: '1', user_id: 'user-name')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/users/user-name/functions/1').to route_to('functions#update', id: '1', user_id: 'user-name')
    end

    it 'routes to #destroy' do
      expect(delete: '/users/user-name/functions/1').to route_to('functions#destroy', id: '1', user_id: 'user-name')
    end
  end
end
