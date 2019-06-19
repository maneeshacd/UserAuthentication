FactoryBot.define do
  factory :user do
    username { 'test_user' }
    email { 'example@gmail.com' }
    password { 'P@ssw0rd' }
    password_confirmation { 'P@ssw0rd' }
  end
end
