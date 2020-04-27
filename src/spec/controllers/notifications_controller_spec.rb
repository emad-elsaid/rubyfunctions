require 'rails_helper'

RSpec.describe NotificationsController do
  let(:function) { create :function }
  let(:current_user) { function.user }
  let(:user) { create :user }
  let(:notification) { create(:notification, notifiable: function, actor: user, recipient: current_user) }

  before { session[:user] = current_user.id }

  describe 'GET #index' do
    it 'returns unread notifications' do
      get :index
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    it 'marks notification as read' do
      get :show, params: { id: notification }
      expect(current_user.notifications.first.read_at).not_to eq(nil)
    end

    it 'redirect likes on functions to functions' do
      get :show, params: { id: notification }
      expect(response).to redirect_to(user_function_url(id: notification.notifiable, user_id: notification.recipient))
    end
  end
end
