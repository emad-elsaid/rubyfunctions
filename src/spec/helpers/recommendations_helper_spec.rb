require 'rails_helper'

RSpec.describe RecommendationsHelper do
  let!(:users) { create_list(:user, 5) }
  let(:functions) { users.map { |user| create_list(:function, 5, user: user) }.flatten }

  describe '#more_from_user_function' do
    it { expect(helper.more_from_user_function(functions.sample)).to include(a_kind_of(Function)) }
  end

  describe '#similar_functions' do
    it { expect(helper.similar_functions(functions.sample)).to include(a_kind_of(Function)) }
  end
end
