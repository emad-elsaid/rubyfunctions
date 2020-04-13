require 'rails_helper'

RSpec.describe CommentsController do
  let(:function) { create :function }
  let(:comment) { build(:comment, function: function, user: current_user) }
  let(:valid_attributes) { comment.attributes }

  let(:user) { function.user }
  let(:current_user) { create :user }

  before { session[:user] = current_user.id }

  describe 'POST #create' do
    context 'with valid params' do
      it 'created a new comment' do
        expect do
          post :create, params: { comment: valid_attributes, function_id: function, user_id: user }
        end.to change(Comment, :count).by(1)
      end

      it 'attach the comment to the function' do
        expect do
          post :create, params: { comment: valid_attributes, function_id: function, user_id: user }
        end.to change(function.comments, :count).by(1)
      end

      it 'comment user is logged in user' do
        expect do
          post :create, params: { comment: valid_attributes, function_id: function, user_id: user }
        end.to change(current_user.comments, :count).by(1)
      end
    end

    context 'invalid parameters' do
      it 'prevents the user' do
        post :create, params: { comment: { content: '' }, function_id: function, user_id: user }
        expect(response).to redirect_to(user_function_url(user, function))
      end

      it 'does not create a comment' do
        expect do
          post :create, params: { comment: { content: '' }, function_id: function, user_id: user }
        end.not_to change(Comment, :count)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested comment' do
      comment.save!
      expect do
        delete :destroy, params: { id: comment.id, function_id: function, user_id: user }
      end.to change(function.comments, :count).by(-1)
    end

    it 'redirects to the function show page' do
      comment.save!
      delete :destroy, params: { id: comment.id, function_id: function, user_id: user }
      expect(response).to redirect_to(user_function_url(user, function))
    end
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      comment.save!
      get :edit, params: { function_id: function, user_id: user, id: comment }
      expect(response).to be_successful
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) { build(:comment).attributes }

      it 'updates the requested function' do
        comment.save!
        put :update, params: { function_id: function, comment: new_attributes, user_id: user, id: comment }
        comment.reload
        expect(comment.content).to eq new_attributes['content']
      end

      it 'redirects to the function' do
        comment.save!
        put :update, params: { function_id: function, comment: new_attributes, user_id: user, id: comment }
        expect(response).to redirect_to([user, function])
      end
    end
  end
end
