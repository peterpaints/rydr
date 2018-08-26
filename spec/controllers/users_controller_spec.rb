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

      it 'increments users count by 1' do
        expect(User.count).to be(1)
      end

      it 'returns a status code of 302' do
        expect(response.status).to eq 302
      end

      it 'redirects to home_path' do
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

      it 'does not increment user count' do
        expect(User.count).to be(0)
      end

      it 'returns a status code of 302' do
        expect(response.status).to eq 302
      end

      it 'redirects to login_path' do
        expect(response).to redirect_to login_path
      end
    end
  end
end
