require 'rails_helper'

RSpec.describe FollowershipsHelper, type: :helper do
  describe '#followed?' do
    let(:user) { create :user }
    let(:current_user) { create :user }

    context 'when current user did not follow the user' do
      it { expect(helper.follows?(current_user, user)).to be_falsey }
    end

    context 'when current user follows user' do
      let!(:followership) { current_user.followings.create(followee: user) }
      it { expect(helper.follows?(current_user, user)).to be_truthy }
    end
  end
end
