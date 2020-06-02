require 'rails_helper'

RSpec.describe TagsController do
  render_views

  describe 'GET #show' do
    let(:tag) { create :tag }
    let!(:functions) { create_list :function, 3, tags: [tag] }
    let(:functions_names) { functions.map(&:name) }

    before { get :show, params: { id: tag } }

    it 'returns all the functions associated with this tag' do
      expect(response).to be_successful
    end

    it 'returns all functions name in response' do
      expect(response.body).to include(*functions_names)
    end
  end
end
