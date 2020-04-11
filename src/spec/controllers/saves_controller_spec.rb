require 'rails_helper'
require 'pry-rails'

RSpec.describe SavesController do
  let(:current_user) { create :user }
  let(:function) { create :function }
  let(:user) { function.user }
  let(:save) { build(:save, function: function, user: current_user) }

  before { session[:user] = current_user.id }

  describe 'POST #create' do
    context 'with valid params' do
      it 'save a function' do
        expect do
          post :create, params: { function_id: function, user_id: user }
        end.to change(current_user.saves, :count).by(1)
      end
    end
  end

  describe 'GET #index' do
    it 'returns a success response' do
      expect do
        current_user.saves.create(function: function)
        get :index, params: { user_id: current_user }
        expect(response).to be_successful
      end
    end
  end

  describe 'DELTE #destroy' do
    it 'remove the function from being saved to the user' do
      save.save!
      expect do
        delete :destroy, params: { function_id: function, user_id: user }
      end.to change(current_user.saves, :count).by(-1)
    end
  end
end
