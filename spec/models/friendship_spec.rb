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

    it 'Inverse friendship' do
      @user.request_friend(@user2)
      @user2.confirm_friend(@user)
      u = User.find(@user.id)
      u2 = User.find(@user2.id)
      f = u.friendships.first
      f2 = u2.friendships.first
      expect(f.user_id).to eq(f2.friend_id)
      expect(f2.user_id).to eq(f.friend_id)
    end
  end
end
