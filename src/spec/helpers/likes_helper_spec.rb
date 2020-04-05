require 'rails_helper'

RSpec.describe LikesHelper do
  describe '#liked?' do
    let(:user) { create :user }
    let(:function) { create :function }

    context 'when user did not like the function' do
      it { expect(helper.liked?(function, user)).to be_falsey }
    end

    context 'when someone else liked the function' do
      let(:another_user) { create :user }
      let!(:like) { function.likes.create(user: another_user) }
      it { expect(helper.liked?(function, user)).to be_falsey }
    end

    context 'when user already liked the function' do
      let!(:like) { function.likes.create(user: user) }
      it { expect(helper.liked?(function, user)).to be_truthy }
    end
  end
end
