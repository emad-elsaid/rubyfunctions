require 'rails_helper'

RSpec.describe FollowershipsController do
  let(:user) { create :user }
  let(:current_user) { create :user }

  before { session[:user] = current_user.id }

  describe 'GET #index' do
    it 'returns a success response for followers' do
      current_user.follower_followerships.create!({ follower: user })
      get :index, params: { user_id: user, relationship: :followers }
      expect(response).to be_successful
    end

    it 'returns a success response for followees' do
      current_user.following_followerships.create!({ followee: user })
      get :index, params: { user_id: user, relationship: :followees }
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    it 'follow' do
      expect do
        post :create, params: { user_id: user.username }
      end.to change(Followership, :count).by(1)
    end
  end

  describe 'DELETE #destroy' do
    before { current_user.following_followerships.create(followee: user) }

    it 'unfollow' do
      expect do
        delete :destroy, params: { user_id: user.username }
      end.to change(Followership, :count).by(-1)
    end
  end

  describe 'DELETE #raise 404 ActiveRecord::NotFound' do
    it 'raise ActiveRecord::NotFound' do
      expect do
        delete :destroy, params: { user_id: user.username }
      end.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
