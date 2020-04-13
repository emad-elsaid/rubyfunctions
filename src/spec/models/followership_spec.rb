require 'rails_helper'

RSpec.describe Followership, type: :model do
  subject { create :followership }
  it { is_expected.to belong_to :follower }
  it { is_expected.to belong_to :followee }

  it 'does not allow follow the same user twice' do
    dup = subject.dup
    expect(dup).to be_invalid
  end

  it 'does not allow follow himself' do
    dup = subject.dup
    dup.follower_id = dup.followee_id
    expect(dup).to be_invalid
    expect(dup.errors.messages).to include(:follower)
  end
end
