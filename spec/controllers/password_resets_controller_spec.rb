require 'rails_helper'

RSpec.describe PasswordResetsController, type: :controller do
  describe 'GET #new' do
    it 'returns http success' do
      get :new
      expect(response).to have_http_status(:success)
    end

    it 'renders the new template' do
      get :new
      expect(response).to render_template('new')
    end
  end

  describe 'GET #edit' do
    let(:user) { create(:user) }
    it 'returns a success response' do
      expect(UserMailer).to receive(:password_reset)
        .and_return(double('UserMailer', deliver: true))
      user.send_password_reset
      get :edit, params: { id: user.password_reset_token }
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'set user reset password fields' do
        post :create,
             params: { email: 'example@gmail.com' }
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe 'PATCH #update' do
    let(:user) { create(:user) }
    context 'with valid params' do
      it 'set user reset password fields' do
        expect(UserMailer).to receive(:password_reset)
          .and_return(double('UserMailer', deliver: true))
        user.send_password_reset
        patch :update,
              params: {
                id: user.password_reset_token,
                user: {
                  password: 'P@ssw0rd',
                  password_confirmation: 'P@ssw0rd'
                }
              }
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
