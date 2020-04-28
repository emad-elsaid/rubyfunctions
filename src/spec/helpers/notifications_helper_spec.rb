require 'rails_helper'

RSpec.describe SavesHelper do
  describe '#unread_notifications' do
    let(:user) { create :user }
    let(:function) { create :function }
    let(:current_user) { function.user }

    before { session[:user] = current_user.id }

    context 'return number of unread notifications only' do
      let(:num_of_notifications) { 5 }
      let(:num_of_read_notifications) { 2 }
      let(:num_of_unread_notifications) { 3 }

      before do
        notifications = create_list(:notification, num_of_notifications,
                                    recipient: current_user, actor: user, notifiable: function)

        num_of_read_notifications.times do |i|
          notifications[i].update!(read_at: DateTime.now)
        end
      end

      it { expect(helper.unread_notifications(current_user)).to eq(num_of_unread_notifications) }
    end
  end
end
