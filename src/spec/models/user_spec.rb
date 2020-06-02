require 'rails_helper'

RSpec.describe User, type: :model do
  subject { create :user, github_id: 'u123' }

  it { is_expected.to have_many :followers }
  it { is_expected.to have_many :following_followerships }
  it { is_expected.to have_many :notifications }

  it { is_expected.to validate_presence_of :name }

  it { is_expected.to validate_presence_of :username }
  it { is_expected.to validate_uniqueness_of :username }
  it { is_expected.to_not allow_value('user#name').for :username }
  it { is_expected.to_not allow_value('user+name').for :username }
  it { is_expected.to_not allow_value('user!name').for :username }
  it { is_expected.to_not allow_value('user\name').for :username }
  it { is_expected.to_not allow_value('user/name').for :username }
  it { is_expected.to_not allow_value('user name').for :username }
  it { is_expected.to_not allow_value('اسم_مستخدم').for :username }
  it { is_expected.to_not allow_value('user.name').for :username }
  it { is_expected.to allow_value('user_name').for :username }
  it { is_expected.to allow_value('user-name').for :username }

  it { is_expected.to validate_presence_of :github_id }
  it { is_expected.to validate_uniqueness_of :github_id }
end
