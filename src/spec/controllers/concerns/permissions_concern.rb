shared_examples_for 'PermissionsConcern' do
  describe 'Function' do
    context 'When user is the owner he can do everything' do
      let(:function) { create :function }
      let(:user) { function.user }

      it { expect(controller.can?(user, function, :index)).to be true }
      it { expect(controller.can?(user, function, :show)).to be true }
      it { expect(controller.can?(user, function, :new)).to be true }
      it { expect(controller.can?(user, function, :edit)).to be true }
      it { expect(controller.can?(user, function, :create)).to be true }
      it { expect(controller.can?(user, function, :update)).to be true }
      it { expect(controller.can?(user, function, :destroy)).to be true }
    end

    context 'When user is not the owner he can read functions' do
      let(:function) { create :function }
      let(:user) { create :user }

      it { expect(controller.can?(user, function, :index)).to be true }
      it { expect(controller.can?(user, function, :show)).to be true }
    end

    context 'When user is not the owner he cannot create or update functions' do
      let(:function) { create :function }
      let(:user) { create :user }

      it { expect(controller.can?(user, function, :new)).to be false }
      it { expect(controller.can?(user, function, :edit)).to be false }
      it { expect(controller.can?(user, function, :create)).to be false }
      it { expect(controller.can?(user, function, :update)).to be false }
      it { expect(controller.can?(user, function, :destroy)).to be false }
    end
  end
end
