require 'rails_helper'

RSpec.describe RelationshipsController do
  let(:user) { create :user }
  let(:current_user) { create :user }

  before { session[:user] = current_user.id }

  describe 'POST #create' do
    it 'follow' do
      expect do
        post :create, params: { user_id: user.id }
      end.to change(Relationship, :count).by(1)
    end
  end

  describe 'DELETE #destroy' do
    before { current_user.follow(user.id) }
    it 'unfollow' do
      expect do
        delete :destroy, params: { user_id: user.id }
      end.to change(Relationship, :count).by(-1)
    end
  end
end
