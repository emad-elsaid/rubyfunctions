require 'rails_helper'

RSpec.describe FunctionsController, type: :controller do
  let(:valid_attributes) { build(:function).attributes }
  let(:invalid_attributes) { build(:function, :invalid_name).attributes }
  let(:user) { create :user }

  before { session[:user] = user.id }

  describe 'GET #index' do
    it 'returns a success response' do
      user.functions.create! valid_attributes
      get :index, params: { user_id: user }
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      function = user.functions.create! valid_attributes
      get :show, params: { id: function, user_id: user }
      expect(response).to be_successful
    end

    it 'respond with the function file when the request url is ended with .rb' do
      function = user.functions.create! valid_attributes
      get :show, params: { id: function, user_id: user }, format: :rb
      expect(response.content_type).to eq 'text/ruby; charset=utf-8'
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get :new, params: { function: valid_attributes, user_id: user }
      expect(response).to be_successful
    end
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      function = user.functions.create! valid_attributes
      get :edit, params: { id: function, user_id: user }
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Function' do
        expect do
          post :create, params: { function: valid_attributes, user_id: user }
        end.to change(Function, :count).by(1)
      end

      it 'redirects to the created function' do
        post :create, params: { function: valid_attributes, user_id: user }
        expect(response).to redirect_to([user, user.functions.last])
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: { function: invalid_attributes, user_id: user }
        expect(response).to be_successful
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:function) { build(:function) }
      let(:new_attributes) { function.attributes }

      it 'updates the requested function' do
        function = user.functions.create! valid_attributes
        put :update, params: { id: function, function: new_attributes, user_id: user }
        function.reload
        expect(function.name).to eq new_attributes['name']
      end

      it 'redirects to the function' do
        function = user.functions.create! valid_attributes
        put :update, params: { id: function, function: valid_attributes, user_id: user }
        expect(response).to redirect_to([user, function])
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'edit' template)" do
        function = user.functions.create! valid_attributes
        put :update, params: { id: function, function: invalid_attributes, user_id: user }
        expect(response).to be_successful
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested function' do
      function = user.functions.create! valid_attributes
      expect do
        delete :destroy, params: { id: function, user_id: user }
      end.to change(user.functions, :count).by(-1)
    end

    it 'redirects to the functions list' do
      function = user.functions.create! valid_attributes
      delete :destroy, params: { id: function, user_id: user }
      expect(response).to redirect_to(user_functions_url(user))
    end
  end
end
