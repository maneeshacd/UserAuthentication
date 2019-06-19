require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET #new' do
    it 'returns a success response' do
      get :new
      expect(response).to be_successful
    end

    it 'renders the new template' do
      get :new
      expect(response).to render_template('new')
    end
  end

  describe 'GET #profile' do
    let(:user) { create(:user) }
    it 'returns a success response' do
      session[:user_id] = user.id
      get :profile
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    let(:user_params) { attributes_for(:user) }
    context 'with valid params' do
      it 'creates a new User' do
        expect {
          post :create,
          params: { user: user_params }
        }.to change(User, :count).by(1)
      end

      it 'redirects to the created user profile' do
        post :create, params: { user: user_params }
        expect(response).to redirect_to(profile_path)
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create,
             params: { user: { email: 'foo' } }
        expect(response).to be_successful
      end
    end
  end

  describe 'PATCH #update' do
    let(:user_params) { attributes_for(:user) }
    let(:user) { create(:user) }
    context 'with valid params' do
      it 'redirects to the updated user profile' do
        session[:user_id] = user.id
        patch :update, params: { id: user.id, user: user_params }
        expect(response).to redirect_to(profile_path)
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'new' template)" do
        session[:user_id] = user.id
        patch :update,
              params: { id: user.id, user: { username: 'foo' } }
        expect(response).to be_successful
      end
    end
  end
end
