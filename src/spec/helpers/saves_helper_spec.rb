require 'rails_helper'

RSpec.describe SavesHelper do
  describe '#saved?' do
    let(:user) { create :user }
    let(:function) { create :function }

    context 'when user did not save the function' do
      it { expect(helper.saved?(function, user)).to be_falsey }
    end

    context 'when someone else save the function' do
      let(:another_user) { create :user }
      let!(:save) { another_user.saves.create(function: function) }
      it { expect(helper.saved?(function, user)).to be_falsey }
    end

    context 'when user already saved the function' do
      let!(:save) { user.saves.create(function: function) }
      it { expect(helper.saved?(function, user)).to be_truthy }
    end
  end
end
