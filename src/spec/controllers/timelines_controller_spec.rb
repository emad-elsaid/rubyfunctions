require 'rails_helper'

RSpec.describe TimelinesController do
  describe 'GET #latest' do
    let!(:function) { create :function }

    it 'returns a success response' do
      get :latest
      expect(response).to be_successful
    end
  end
end
