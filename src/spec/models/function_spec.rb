require 'rails_helper'

RSpec.describe Function, type: :model do
  subject { create :function }

  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_uniqueness_of :name }
  it { is_expected.to validate_presence_of :usage }
  it { is_expected.to validate_presence_of :code }
end
