require 'rails_helper'

RSpec.describe Notification::Notification, type: :model do
  subject { create :notification }

  it { is_expected.to belong_to :recipient }
  it { is_expected.to belong_to :actor }
end
