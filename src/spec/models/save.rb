require 'rails_helper'

RSpec.describe SavedFunction, type: :model do
  subject { create :saved_function }

  it { is_expected.to belong_to :user }
  it { is_expected.to belong_to :function }

  it 'must be unique in user scope' do
    duplicate = subject.dup
    expect(duplicate).to be_invalid
  end
end
