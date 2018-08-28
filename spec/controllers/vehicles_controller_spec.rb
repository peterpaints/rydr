require 'rails_helper'

RSpec.describe VehiclesController, type: :controller do
  let(:user) { create(:user) }

  describe 'POST #create' do
    context 'create request is valid' do
      before do
        stub_current_user(user)
        post :create, params: {
          vehicle: attributes_for(:vehicle)
        }
      end

      it 'increases vehicles count by 1' do
        expect(Vehicle.count).to be(1)
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
          vehicle: attributes_for(:vehicle, license_plate: nil)
        }
      end

      it 'does not increase vehicle count' do
        expect(Vehicle.count).to be(0)
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
    let(:vehicle) { create :vehicle }

    context 'when update request is valid' do
      before do
        stub_current_user(user)
        put :update,
            params: { id: vehicle.id,
                      vehicle: attributes_for(:vehicle, capacity: 6) }
      end

      it 'redirects to user path' do
        expect(response).to redirect_to user_path(user.id)
      end

      it 'returns status_code 302' do
        expect(response.status).to eq 302
      end

      it "updates the vehicle's capacity" do
        expect(vehicle.reload.capacity).to eq 6
        expect(flash[:success]).to eq 'Vehicle saved!'
      end
    end

    context 'when update request is invalid' do
      before do
        stub_current_user(user)
        put :update,
            params: { id: vehicle.id,
                      vehicle: attributes_for(:vehicle, capacity: 0) }
      end

      it 'shows flash error' do
        expect(assigns(:vehicle).errors[:capacity]).to include 'is invalid'
        expect(flash[:danger]).to eq 'is invalid'
      end
    end
  end

  describe 'GET #destroy' do
    let(:vehicle) { create(:vehicle) }

    before do
      stub_current_user(user)
      get :destroy, params: { id: vehicle.id }
    end

    it 'deletes vehicle object' do
      expect(Vehicle.count).to eq 0
    end

    it 'redirects to user path' do
      expect(response).to redirect_to user_path(user.id)
    end

    it 'returns status_code 302' do
      expect(response.status).to eq 302
    end

    it 'shows flash success' do
      expect(flash[:success]).to eq 'Shame. It was a nice car.'
    end
  end
end
