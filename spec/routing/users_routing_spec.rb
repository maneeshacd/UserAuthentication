require 'rails_helper'

RSpec.describe UsersController, type: :routing do
  describe 'routing' do
    it 'routes to #new' do
      expect(get: '/').to route_to('users#new')
    end

    it 'routes to #profile' do
      expect(get: '/profile').to route_to('users#profile')
    end

    it 'routes to #create' do
      expect(post: '/users').to route_to('users#create')
    end

    it 'routes to #update' do
      expect(patch: '/users/1/').to route_to('users#update', id: '1')
    end
  end
end
