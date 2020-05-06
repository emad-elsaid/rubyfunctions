require 'rails_helper'

RSpec.describe TagsController do
  describe 'GET #show' do
    let!(:functions_count) { 3 }

    let(:tag) { create :tag }
    let(:functions) { create_list :function, functions_count, tags: [tag] }

    it 'returns all the funtions associated with this tag' do
      get :show, params: { id: tag }
      expect(response).to be_successful
    end
  end
end
