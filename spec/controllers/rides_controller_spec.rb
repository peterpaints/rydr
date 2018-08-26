require 'rails_helper'

RSpec.describe RidesController, type: :controller do
  describe 'GET #index' do
    let(:user) { create :user }

    before do
      stub_current_user(user)
      get :index
    end

    it 'renders the index template' do
      expect(response).to render_template :index
    end

    it 'returns a 200 status' do
      expect(response.status).to eq 200
    end
  end

  describe 'POST #create' do
    let(:user) { create(:user) }
    let(:vehicle) { create(:vehicle) }
    context 'create request is valid' do
      before do
        stub_current_user(user)
        post :create, params: {
          ride: attributes_for(:ride, vehicle_id: vehicle.id)
        }
      end

      it 'increases rides count by 1' do
        expect(flash[:success]).to be_present
        expect(Ride.count).to be(1)
      end

      it 'returns status_code 302' do
        expect(response.status).to eq 302
      end

      it 'redirects to user_path' do
        expect(response).to redirect_to user_path(user.id)
      end
    end

    context 'create request is invalid' do
      before do
        stub_current_user(user)
        post :create, params: {
          ride: attributes_for(:ride, vehicle_id: nil)
        }
      end

      it 'does not increase ride count' do
        expect(Ride.count).to be(0)
      end

      it 'returns status_code 302' do
        expect(response.status).to eq 302
      end

      it 'redirects to user_path' do
        expect(response).to redirect_to user_path(user.id)
      end

      it 'shows flash error' do
        expect(flash[:danger]).to be_present
      end
    end
  end

  describe 'PUT #update' do
    let(:user) { create :user }
    let(:vehicle) { create(:vehicle) }
    let(:ride) { create :ride, vehicle_id: vehicle.id }

    context 'when update request is valid' do
      before do
        stub_current_user(user)
        put :update,
            params: { id: ride.id,
                      ride: attributes_for(:ride, capacity: 6,
                                                  vehicle_id: vehicle.id) }
      end

      it 'redirects to user path' do
        expect(response).to redirect_to user_path(user.id)
      end

      it 'returns status_code 302' do
        expect(response.status).to eq 302
      end

      it "updates the ride's capacity" do
        expect(ride.reload.capacity).to eq 6
        expect(flash[:success]).to eq 'Ride saved!'
      end
    end

    context 'when update request is invalid' do
      before do
        stub_current_user(user)
        put :update,
            params: { id: ride.id,
                      ride: attributes_for(:ride, capacity: 0,
                                                  vehicle_id: vehicle.id) }
      end

      it 'shows flash error' do
        expect(assigns(:ride).errors[:capacity]).to include 'is invalid'
        expect(flash[:danger]).to eq 'is invalid'
      end
    end
  end

  describe 'GET #book' do
    let(:user) { create :user }
    let(:vehicle) { create(:vehicle) }
    let(:ride) { create(:ride, vehicle_id: vehicle.id) }

    context 'when user is not ride owner' do
      before do
        stub_current_user(user)
        get :book, params: { id: ride.id }
      end

      it 'assigns user to ride' do
        expect(assigns(:ride).users).to include user
      end

      it 'redirects to rides path' do
        expect(response).to redirect_to rides_path
      end

      it 'returns status_code 302' do
        expect(response.status).to eq 302
      end

      it 'shows flash success' do
        expect(flash[:success]).to eq 'Ride booked!'
      end
    end

    context 'when user is ride owner' do
      before do
        stub_current_user(user)
        user.vehicles << vehicle
        get :book, params: { id: ride.id }
      end

      it 'fails to assign user to ride' do
        expect(assigns(:ride).users).not_to include user
      end

      it 'redirects to rides path' do
        expect(response).to redirect_to rides_path
      end

      it 'returns status_code 302' do
        expect(response.status).to eq 302
      end

      it 'shows error message' do
        expect(flash[:danger]).to eq 'You can not book a ride you own.'
      end
    end
  end

  describe 'GET #cancel' do
    let(:user) { create :user }
    let(:vehicle) { create(:vehicle) }
    let(:ride) { create(:ride, vehicle_id: vehicle.id) }

    before do
      stub_current_user(user)
      get :book, params: { id: ride.id }
      get :cancel, params: { id: ride.id }
    end

    it 'user not to be booked to ride' do
      expect(assigns(:ride).users).not_to include user
    end

    it 'redirects to user path' do
      expect(response).to redirect_to rides_path
    end

    it 'returns status_code 302' do
      expect(response.status).to eq 302
    end

    it 'shows flash success' do
      expect(flash[:success]).to eq 'Ride cancelled. What\'s up?'
    end
  end

  describe 'GET #destroy' do
    let(:user) { create :user }
    let(:vehicle) { create(:vehicle) }
    let(:ride) { create(:ride, vehicle_id: vehicle.id) }

    before do
      stub_current_user(user)
      get :destroy, params: { id: ride.id }
    end

    it 'deletes ride object' do
      expect(Ride.count).to eq 0
    end

    it 'redirects to user path' do
      expect(response).to redirect_to user_path(user.id)
    end

    it 'returns status_code 302' do
      expect(response.status).to eq 302
    end

    it 'shows flash success' do
      expect(flash[:success]).to eq 'Ride deleted. Now we have to walk?'
    end
  end
end
