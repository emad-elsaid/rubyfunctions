require 'rails_helper'

RSpec.describe LikesController do
  let(:function) { create :function }
  let(:user) { function.user }
  let(:current_user) { create :user }

  before { session[:user] = current_user.id }

  describe 'POST #create' do
    it 'creates a like' do
      expect do
        post :create, params: { function_id: function, user_id: user }
      end.to change(Like, :count).by(1)
    end
  end

  describe 'DELETE #destroy' do
    before { function.likes.create(user: current_user) }

    it 'deletes a like' do
      expect do
        delete :destroy, params: { function_id: function, user_id: user }
      end.to change(Like, :count).by(-1)
    end
  end
end
