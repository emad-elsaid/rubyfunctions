require 'rails_helper'

RSpec.describe TagsController do
  describe 'GET #show' do
    let(:tag) { create :tag }

    before { get :show, params: { id: tag } }

    it 'returns all the functions associated with this tag' do
      expect(response).to be_successful
    end
  end
end
