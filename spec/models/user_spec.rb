require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Check secure password' do
    it { should have_secure_password }
  end

  describe 'Validations' do
    subject { create(:user) }

    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should allow_value('email@addresse.foo').for(:email) }
    it { should_not allow_value('foo').for(:email) }
    it { should validate_length_of(:username).is_at_least(5) }
    it { should validate_length_of(:password).is_at_least(8) }
  end

  describe 'before save methods' do
    context 'responds to its methods' do
      it { expect(User.new).to respond_to(:set_username) }
    end

    context 'executes methods correctly' do
      let(:user_params) do
        attributes_for(:user).merge(skip_username_validation: true)
      end
      it 'set username as email prefix' do
        user = User.create(user_params)
        expect(user.username).to eq('example')
      end
    end
  end

  describe 'instance methods' do
    context 'responds to its methods' do
      it { expect(User.new).to respond_to(:send_password_reset) }
    end

    context 'update reset fields' do
      let(:user) { create(:user) }
      it 'sets password_reset_token and password_reset_sent_at' do
        expect(UserMailer).to receive(:password_reset)
          .and_return(double('UserMailer', deliver: true))
        user.send_password_reset
        expect(user.password_reset_sent_at).not_to eq(nil)
        expect(user.password_reset_token).not_to eq(nil)
      end
    end
  end
end
