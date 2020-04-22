require 'rails_helper'

RSpec.describe NotificationsController do
  let(:function) { create :function }
  let(:current_user) { function.user }
  let(:user) { create :user }

  before { session[:user] = current_user.id }

  describe 'GET #index' do
    it 'returns unread notifications' do
      get :index
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    before do
      old_controller = @controller
      session[:user] = user.id
      @controller = LikesController.new
      post :create, params: { function_id: function, user_id: current_user }
      session[:user] = current_user.id
      @controller = old_controller
    end

    it 'returns unread notifications' do
      get :show, params: { id: current_user.notifications.first }
      expect(response).to redirect_to(user_function_url(id: function, user_id: function.user))
    end
  end
end
