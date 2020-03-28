require "rails_helper"

RSpec.describe SessionsController do
  let(:user) { create :user }

  describe 'DELETE #destroy' do
    before { session[:user] = user.id }
    it 'resets the session' do
      delete :destroy
      expect(session[:user]).to be_nil
    end
  end
end
