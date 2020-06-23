require 'rails_helper'

RSpec.describe Friendship, type: :model do
  context 'context' do
    before do
      @user = User.create(email: 'mail@mail.com', name: 'Tester', password: '123456')
      @user2 = User.create(email: 'mail2@mail.com', name: 'Tester2', password: '123456')
    end

    it 'pending friendship' do
      @user.request_friend(@user2)
      f = @user.friendships.first
      expect(f.confirmed).to eq(false)
    end

    it 'accepted friendship' do
      @user.request_friend(@user2)
      @user2.confirm_friend(@user)
      u = User.find(@user.id)
      f = u.friendships.first
      expect(f.confirmed).to eq(true)
    end
  end
end
