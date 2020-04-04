require 'rails_helper'

RSpec.describe Function, type: :model do
  subject { create :function }

  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_uniqueness_of(:name).scoped_to(:user_id) }
  it { is_expected.to allow_value('function_name').for :name }
  it { is_expected.to allow_value('functionName').for :name }
  it { is_expected.to allow_value('function1').for :name }
  it { is_expected.to allow_value('function!').for :name }
  it { is_expected.to allow_value('function?').for :name }
  it { is_expected.to_not allow_value('name with space').for :name }
  it { is_expected.to_not allow_value('name_with\backslash').for :name }
  it { is_expected.to_not allow_value('اسم_عربي').for :name }

  it { is_expected.to validate_presence_of :usage }
  it { is_expected.to validate_presence_of :code }
  it { is_expected.to validate_presence_of :user }
end
