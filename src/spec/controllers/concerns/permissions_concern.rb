shared_examples_for 'PermissionsConcern' do
  before { session[:user] = user&.id }

  describe 'Function' do
    context 'When user is the owner he can do everything' do
      let(:function) { create :function }
      let(:user) { function.user }

      it { expect(controller.can?(function, :index)).to be_truthy }
      it { expect(controller.can?(function, :show)).to be_truthy }
      it { expect(controller.can?(function, :new)).to be_truthy }
      it { expect(controller.can?(function, :edit)).to be_truthy }
      it { expect(controller.can?(function, :create)).to be_truthy }
      it { expect(controller.can?(function, :update)).to be_truthy }
      it { expect(controller.can?(function, :destroy)).to be_truthy }
    end

    context 'When user is not the owner he can read functions' do
      let(:function) { create :function }
      let(:user) { create :user }

      it { expect(controller.can?(function, :index)).to be_truthy }
      it { expect(controller.can?(function, :show)).to be_truthy }
    end

    context 'When user is not the owner he cannot create or update functions' do
      let(:function) { create :function }
      let(:user) { create :user }

      it { expect(controller.can?(function, :new)).to be_falsey }
      it { expect(controller.can?(function, :edit)).to be_falsey }
      it { expect(controller.can?(function, :create)).to be_falsey }
      it { expect(controller.can?(function, :update)).to be_falsey }
      it { expect(controller.can?(function, :destroy)).to be_falsey }
    end
  end

  describe 'Comment' do
    context 'A guest can read comments' do
      let(:comment) { create :comment }
      let(:user) { nil }

      it { expect(controller.can?(comment, :index)).to be_truthy }
      it { expect(controller.can?(comment, :show)).to be_truthy }
      it { expect(controller.can?(comment, :new)).to be_falsey }
      it { expect(controller.can?(comment, :edit)).to be_falsey }
      it { expect(controller.can?(comment, :create)).to be_falsey }
      it { expect(controller.can?(comment, :update)).to be_falsey }
      it { expect(controller.can?(comment, :destroy)).to be_falsey }
    end

    context 'a user can own comments' do
      let(:comment) { create :comment }
      let(:user) { comment.user }

      it { expect(controller.can?(comment, :index)).to be_truthy }
      it { expect(controller.can?(comment, :show)).to be_truthy }
      it { expect(controller.can?(comment, :new)).to be_truthy }
      it { expect(controller.can?(comment, :edit)).to be_truthy }
      it { expect(controller.can?(comment, :create)).to be_truthy }
      it { expect(controller.can?(comment, :update)).to be_truthy }
      it { expect(controller.can?(comment, :destroy)).to be_truthy }
    end

    context 'a comment function owner' do
      let(:comment) { create :comment }
      let(:user) { comment.function.user }

      it { expect(controller.can?(comment, :index)).to be_truthy }
      it { expect(controller.can?(comment, :show)).to be_truthy }
      it { expect(controller.can?(comment, :new)).to be_falsey }
      it { expect(controller.can?(comment, :edit)).to be_falsey }
      it { expect(controller.can?(comment, :create)).to be_falsey }
      it { expect(controller.can?(comment, :update)).to be_falsey }
      it { expect(controller.can?(comment, :destroy)).to be_truthy }
    end

    context 'a user that does not own the function or the comment' do
      let(:comment) { create :comment }
      let(:user) { create :user }

      it { expect(controller.can?(comment, :index)).to be_truthy }
      it { expect(controller.can?(comment, :show)).to be_truthy }
      it { expect(controller.can?(comment, :new)).to be_falsey }
      it { expect(controller.can?(comment, :edit)).to be_falsey }
      it { expect(controller.can?(comment, :create)).to be_falsey }
      it { expect(controller.can?(comment, :update)).to be_falsey }
      it { expect(controller.can?(comment, :destroy)).to be_falsey }
    end
  end

  describe 'Like' do
    context 'for a guest' do
      let(:like) { create :like }
      let(:user) { nil }

      it { expect(controller.can?(like, :create)).to be_falsey }
      it { expect(controller.can?(like, :destroy)).to be_falsey }
    end

    context 'for a user' do
      let(:like) { create :like }
      let(:user) { like.user }

      it { expect(controller.can?(like, :create)).to be_truthy }
      it { expect(controller.can?(like, :destroy)).to be_truthy }
    end

    context 'for a user that does not own the like' do
      let(:like) { create :like }
      let(:user) { create :user }

      it { expect(controller.can?(like, :create)).to be_falsey }
      it { expect(controller.can?(like, :destroy)).to be_falsey }
    end
  end

  describe 'Save' do
    context 'for a guest' do
      let(:save) { create :save }
      let(:user) { nil }

      it { expect(controller.can?(save, :create)).to be_falsy }
      it { expect(controller.can?(save, :destroy)).to be_falsy }
    end

    context 'for a user' do
      let(:save) { create :save }
      let(:user) { save.user }

      it { expect(controller.can?(save, :create)).to be_truthy }
      it { expect(controller.can?(save, :destroy)).to be_truthy }
    end

    context 'for a user that does not own the saved function' do
      let(:save) { create :save }
      let(:user) { create :user }

      it { expect(controller.can?(save, :create)).to be_falsy }
      it { expect(controller.can?(save, :destroy)).to be_falsy }
    end
  end
end
