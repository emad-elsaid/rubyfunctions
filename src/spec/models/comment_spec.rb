require 'rails_helper'

RSpec.describe Comment, type: :model do
  subject { create :comment }

  it { is_expected.to belong_to :user }
  it { is_expected.to belong_to :function }
  it { is_expected.to validate_presence_of :content }
end
