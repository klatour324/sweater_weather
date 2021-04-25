require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it {should validate_presence_of(:email)}
    it {should validate_uniqueness_of(:email)}
    it {should validate_presence_of(:password)}
  end

  describe 'instance methods' do
    describe 'set_api_key' do
      it 'sets the api key for a user' do
        user = User.create(email: 'whatever@example.com', password: 'password')

        expect(user.api_key).to be_a(String)
        expect(user.api_key.length).to eq(28)
      end
    end

    describe 'generate_api_key' do
      it 'generates a randomly secure api_key' do
        user = User.create(email: 'whatever@example.com', password: 'password')

        expect(user.generate_api_key).to be_a(String)
        expect(user.generate_api_key.length).to eq(28)
      end
    end
  end
end
