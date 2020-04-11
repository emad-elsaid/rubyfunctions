require 'rails_helper'

RSpec.describe TimelinesController do
  describe 'GET #latest' do
    let!(:function) { create :function }

    it 'returns a success response' do
      get :latest
      expect(response).to be_successful
    end
  end

  describe 'GET #liked' do
    let!(:function) { create :function }

    it 'returns a success response' do
      get :liked
      expect(response).to be_successful
    end
  end

  describe 'GET #commented' do
    let!(:function) { create :function }

    it 'returns a success response' do
      get :commented
      expect(response).to be_successful
    end
  end

  describe 'GET #saved' do
    let!(:function) { create :function }

    it 'returns a success response' do
      get :saved
      expect(response).to be_successful
    end
  end

  describe 'GET #contributors' do
    let!(:user) { create :user }

    it 'returns a success response' do
      get :contributors
      expect(response).to be_successful
    end
  end
end
