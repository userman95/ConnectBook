require 'rails_helper'

RSpec.describe User, type: :model do

  context 'validation tests' do

    let(:user) { User.new(name: 'Efrain', email: 'e@g.c', password: '123456') }

    it 'user should be valid' do
      expect(user.valid?).to eq(true) 
    end

    it 'name should be present' do
      expect(user.name).not_to be_empty
    end

    it 'email should be present' do
      expect(user.email).not_to be_empty
    end

    it 'password should be present' do
      expect(user.password).not_to be_empty
    end

    it 'password length should at least 6 characters' do
      expect(user.password.length).to be >= 6
    end
  end

  context 'association tests' do

    let(:requester) { User.new(name: 'Efrain', email: 'e@g.c', password: '123456') }
    let(:invited) { User.new(name: 'Orestis', email: 'o@g.c', password: '123456') }

    it 'user can send a friend request to another' do

    end
  end
end
