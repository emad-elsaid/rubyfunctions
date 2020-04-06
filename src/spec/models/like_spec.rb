require 'rails_helper'

RSpec.describe Like, type: :model do
  subject { create :like }

  it { is_expected.to belong_to :user }
  it { is_expected.to belong_to :likeable }

  it 'does not allow like for same user to same likeable' do
    dup = subject.dup
    expect(dup).to be_invalid
  end
end
