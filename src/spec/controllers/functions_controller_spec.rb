require 'rails_helper'

RSpec.describe FunctionsController, type: :controller do
  let(:valid_attributes) { build(:function).attributes }
  let(:invalid_attributes) { build(:function, :invalid_name).attributes }

  describe 'GET #index' do
    it 'returns a success response' do
      Function.create! valid_attributes
      get :index, params: {}
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      function = Function.create! valid_attributes
      get :show, params: { id: function.to_param }
      expect(response).to be_successful
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get :new, params: { function: valid_attributes }
      expect(response).to be_successful
    end
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      function = Function.create! valid_attributes
      get :edit, params: { id: function.to_param }
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Function' do
        expect do
          post :create, params: { function: valid_attributes }
        end.to change(Function, :count).by(1)
      end

      it 'redirects to the created function' do
        post :create, params: { function: valid_attributes }
        expect(response).to redirect_to(Function.last)
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: { function: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) { build(:function).attributes }

      it 'updates the requested function' do
        function = Function.create! valid_attributes
        put :update, params: { id: function.to_param, function: new_attributes }
        function.reload
        expect(function.name).to eq new_attributes['name']
      end

      it 'redirects to the function' do
        function = Function.create! valid_attributes
        put :update, params: { id: function.to_param, function: valid_attributes }
        expect(response).to redirect_to(function)
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'edit' template)" do
        function = Function.create! valid_attributes
        put :update, params: { id: function.to_param, function: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested function' do
      function = Function.create! valid_attributes
      expect do
        delete :destroy, params: { id: function.to_param }
      end.to change(Function, :count).by(-1)
    end

    it 'redirects to the functions list' do
      function = Function.create! valid_attributes
      delete :destroy, params: { id: function.to_param }
      expect(response).to redirect_to(functions_url)
    end
  end
end
