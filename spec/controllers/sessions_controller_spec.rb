require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
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

  describe 'POST #create' do
    let(:user) { create(:user) }
    context 'with valid params' do
      it 'redirects loggedin user to profile' do
        post :create,
             params: {
               user: { email: 'example@gmail.com', password: 'P@ssw0rd' }
             }
        expect(response).to be_successful
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

  describe 'GET #destroy' do
    let(:user) { create(:user) }
    it 'sets session to nil' do
      session[:user_id] = user.id
      get :destroy
      expect(session[:user_id]).to be_nil
    end
  end
end
