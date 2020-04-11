RSpec.describe Relationship, type: :model do
  subject { create :relationship }
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
  end
end
