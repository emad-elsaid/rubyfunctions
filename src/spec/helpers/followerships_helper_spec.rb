require 'rails_helper'

RSpec.describe FollowershipsHelper, type: :helper do
  describe '#followed?' do
    let(:user) { create :user }
    let(:current_user) { create :user }

    context 'when current user did not follow the user' do
      it { expect(helper.follows?(current_user.id, user.id)).to be_falsey }
    end

    context 'when current user follows user' do
      let!(:follow) { current_user.follow(user.id) }
      it { expect(helper.follows?(current_user.id, user.id)).to be_truthy }
    end
  end
end
