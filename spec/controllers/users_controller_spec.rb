require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET #new' do
    before(:each) { get :new }

    it 'returns status_code 200' do
      expect(response.status).to eq 200
    end

    it 'renders new template' do
      expect(response).to render_template(:new)
    end
  end

  describe 'POST #create' do
    context 'valid user' do
      let(:valid_request) do
        post :create, params: {
          user: attributes_for(:user)
        }
      end
      before(:each) { valid_request }

      it 'increases users count by 1' do
        expect(User.count).to be(1)
      end

      it 'returns status_code 302' do
        expect(response.status).to eq 302
      end

      it 'redirects to user_path' do
        expect(response).to redirect_to user_path(User.first.id)
      end
    end

    context 'with invalid attributes' do
      let(:invalid_request) do
        post :create, params: {
          user: { email: '', password: '' }
        }
      end
      before(:each) { invalid_request }

      it 'does not increase user count' do
        expect(User.count).to be(0)
      end

      it 'returns status_code 302' do
        expect(response.status).to eq 302
      end

      it 'redirects to login_path' do
        expect(response).to redirect_to login_path
      end
    end
  end

  describe 'GET #show' do
    let(:user) { create :user }

    before do
      stub_current_user(user)
      get :show, params: { id: user.id }
    end

    it 'renders show template' do
      expect(response).to render_template(:show)
    end

    it 'returns status_code 200' do
      expect(response.status).to eq 200
    end
  end

  describe 'PUT #update' do
    let(:user) { create :user }

    context 'when update request is valid' do
      before do
        stub_current_user(user)
        put :update,
            params: { id: user.id,
                      user: attributes_for(:user, slack_handle: '@bla') }
      end

      it 'redirects to user path' do
        expect(response).to redirect_to user_path(user.id)
      end

      it 'returns status_code 302' do
        expect(response.status).to eq 302
      end

      it "updates the user's slack_handle" do
        expect(user.reload.slack_handle).to eq '@bla'
        expect(flash[:success]).to eq 'Settings updated!'
      end
    end

    context 'when update request is invalid' do
      before do
        stub_current_user(user)
        put :update,
            params: { id: user.id,
                      user: attributes_for(:user, slack_handle: 'bla') }
      end

      it 'shows flash error' do
        expect(assigns(:user).errors[:slack_handle]).to include 'is invalid'
        expect(flash[:danger]).to eq 'is invalid'
      end
    end
  end
end
