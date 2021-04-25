FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { "password" }
    api_key { "0123456789abcdefghijklmnopq" }
  end
end
