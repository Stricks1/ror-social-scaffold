require 'rails_helper'

RSpec.describe User, type: :model do
  context 'context' do
    before do
      @user = User.create(email: 'mail@mail.com', name: 'Tester', password: '123456')
      @user2 = User.create(email: 'mail2@mail.com', name: 'Tester2', password: '123456')
    end

    it 'show friends confirmed' do
      @user.request_friend(@user2)
      @user2.confirm_friend(@user)
      u1 = User.find(@user.id)
      expect(u1.friends.first.id).to be @user2.id
    end

    it 'show pending friends' do
      @user.request_friend(@user2)
      expect(@user.pending_friends.first.id).to be @user2.id
    end

    it 'show friend requests' do
      @user.request_friend(@user2)
      expect(@user2.friend_requests.first.id).to be @user.id
    end

    it 'request friend' do
      @user.request_friend(@user2)
      expect(@user2.friend_requests.first.id).to be @user.id
    end

    it 'request friend secound time' do
      @user.request_friend(@user2)
      expect(@user.request_friend(@user2)).to be false
    end

    it 'Reject friend request' do
      @user.request_friend(@user2)
      @user2.reject_friend(@user)
      u1 = User.find(@user.id)
      expect(u1.friends.first).to be nil
    end

    it 'Friend checking' do
      @user.request_friend(@user2)
      @user2.confirm_friend(@user)
      u1 = User.find(@user.id)
      expect(u1.friend?(@user2)).to be true
    end
  end
end