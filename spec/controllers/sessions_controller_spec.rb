require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe 'GET #new' do
    before(:each) {  get :new }
    it 'returns status_code 200' do
      expect(response.status).to eq 200
    end

    it 'renders new template' do
      expect(response).to render_template(:new)
    end
  end

  describe 'POST #create' do
    let(:user) { create(:user) }

    context 'with valid credentials' do
      before(:each) do
        post :create, params: { email: user.email, password: user.password }
      end

      it 'returns status_code 302' do
        expect(response.status).to eq 302
      end

      it 'redirects to rides path' do
        expect(response).to redirect_to rides_path
      end

      it 'sets session to user id' do
        expect(session[:user]).to eq user.id
      end
    end

    context 'with invalid credentials' do
      before(:each) do
        post :create, params: { email: '', password: '' }
      end

      it 'shows error flash' do
        expect(flash[:danger]).to eql('Invalid email or password.')
      end

      it 'redirects to login path' do
        expect(response).to redirect_to login_path
      end

      it 'should not have a session' do
        expect(session[:user]).to be_nil
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:user) { create(:user) }
    before(:each) do
      stub_current_user(user)
      get :destroy
    end
    it 'destroys user session' do
      expect(session[:user]).to be_nil
    end

    it 'returns status_code 302' do
      expect(response.status).to eq 302
    end

    it 'redirects to login path' do
      expect(response).to redirect_to login_path
    end
  end
end
