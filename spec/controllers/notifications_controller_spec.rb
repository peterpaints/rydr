require 'rails_helper'

RSpec.describe NotificationsController, type: :controller do
  let(:user) { create :user }

  describe 'POST #create' do
    context 'create request is valid' do
      before do
        stub_current_user(user)
        user.notifications.create(attributes_for(:notification))
      end

      it 'increases notifications count by 1' do
        expect(Notification.count).to be(1)
      end
    end
  end

  describe 'GET #mark_as_read' do
    before do
      stub_current_user(user)
      user.notifications.create(attributes_for(:notification))
      get :mark_as_read, xhr: true
    end

    it 'notification to be marked as read' do
      expect(user.notifications.first.reload.read).to eq true
    end
  end
end
