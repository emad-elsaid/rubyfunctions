shared_examples_for 'PermissionsConcern' do
  describe 'Function' do
    context 'When user is the owner he can do everything' do
      let(:function) { create :function }
      let(:user) { function.user }

      it { expect(controller.can?(user, function, :index)).to be_truthy }
      it { expect(controller.can?(user, function, :show)).to be_truthy }
      it { expect(controller.can?(user, function, :new)).to be_truthy }
      it { expect(controller.can?(user, function, :edit)).to be_truthy }
      it { expect(controller.can?(user, function, :create)).to be_truthy }
      it { expect(controller.can?(user, function, :update)).to be_truthy }
      it { expect(controller.can?(user, function, :destroy)).to be_truthy }
    end

    context 'When user is not the owner he can read functions' do
      let(:function) { create :function }
      let(:user) { create :user }

      it { expect(controller.can?(user, function, :index)).to be_truthy }
      it { expect(controller.can?(user, function, :show)).to be_truthy }
    end

    context 'When user is not the owner he cannot create or update functions' do
      let(:function) { create :function }
      let(:user) { create :user }

      it { expect(controller.can?(user, function, :new)).to be_falsey }
      it { expect(controller.can?(user, function, :edit)).to be_falsey }
      it { expect(controller.can?(user, function, :create)).to be_falsey }
      it { expect(controller.can?(user, function, :update)).to be_falsey }
      it { expect(controller.can?(user, function, :destroy)).to be_falsey }
    end
  end

  describe 'Comment' do
    context 'A guest can read comments' do
      let(:comment) { create :comment }
      let(:user) { nil }

      it { expect(controller.can?(user, comment, :index)).to be_truthy }
      it { expect(controller.can?(user, comment, :show)).to be_truthy }
      it { expect(controller.can?(user, comment, :new)).to be_falsey }
      it { expect(controller.can?(user, comment, :edit)).to be_falsey }
      it { expect(controller.can?(user, comment, :create)).to be_falsey }
      it { expect(controller.can?(user, comment, :update)).to be_falsey }
      it { expect(controller.can?(user, comment, :destroy)).to be_falsey }
    end

    context 'a user can own comments' do
      let(:comment) { create :comment }
      let(:user) { comment.user }

      it { expect(controller.can?(user, comment, :index)).to be_truthy }
      it { expect(controller.can?(user, comment, :show)).to be_truthy }
      it { expect(controller.can?(user, comment, :new)).to be_truthy }
      it { expect(controller.can?(user, comment, :edit)).to be_truthy }
      it { expect(controller.can?(user, comment, :create)).to be_truthy }
      it { expect(controller.can?(user, comment, :update)).to be_truthy }
      it { expect(controller.can?(user, comment, :destroy)).to be_truthy }
    end

    context 'a comment function owner' do
      let(:comment) { create :comment }
      let(:user) { comment.function.user }

      it { expect(controller.can?(user, comment, :index)).to be_truthy }
      it { expect(controller.can?(user, comment, :show)).to be_truthy }
      it { expect(controller.can?(user, comment, :new)).to be_falsey }
      it { expect(controller.can?(user, comment, :edit)).to be_falsey }
      it { expect(controller.can?(user, comment, :create)).to be_falsey }
      it { expect(controller.can?(user, comment, :update)).to be_falsey }
      it { expect(controller.can?(user, comment, :destroy)).to be_truthy }
    end

    context 'a user that does not own the function or the comment' do
      let(:comment) { create :comment }
      let(:user) { create :user }

      it { expect(controller.can?(user, comment, :index)).to be_truthy }
      it { expect(controller.can?(user, comment, :show)).to be_truthy }
      it { expect(controller.can?(user, comment, :new)).to be_falsey }
      it { expect(controller.can?(user, comment, :edit)).to be_falsey }
      it { expect(controller.can?(user, comment, :create)).to be_falsey }
      it { expect(controller.can?(user, comment, :update)).to be_falsey }
      it { expect(controller.can?(user, comment, :destroy)).to be_falsey }
    end
  end

  describe 'Like' do
    context 'for a guest' do
      let(:like) { create :like }
      let(:user) { nil }

      it { expect(controller.can?(user, like, :create)).to be_falsey }
      it { expect(controller.can?(user, like, :destroy)).to be_falsey }
    end

    context 'for a user' do
      let(:like) { create :like }
      let(:user) { like.user }

      it { expect(controller.can?(user, like, :create)).to be_truthy }
      it { expect(controller.can?(user, like, :destroy)).to be_truthy }
    end

    context 'for a user that does not own the like' do
      let(:like) { create :like }
      let(:user) { create :user }

      it { expect(controller.can?(user, like, :create)).to be_falsey }
      it { expect(controller.can?(user, like, :destroy)).to be_falsey }
    end
  end
end
