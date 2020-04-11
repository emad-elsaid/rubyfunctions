require 'rails_helper'

RSpec.describe Follow, type: :model do
  it { is_expected.to belong_to :follower }
  it { is_expected.to belong_to :following }
end
