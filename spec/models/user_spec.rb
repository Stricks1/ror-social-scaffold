require 'rails_helper'

RSpec.describe User, type: :model do
  context 'context' do
    it 'request friend' do
        user = User.create(email: 'mail@mail.com', name: 'Tester', password: '123456')
        user2 = User.create(email: 'mail2@mail.com', name: 'Tester2', password: '123456')
        user.request_friend(user2)
        expect(user2.friend_requests.first.id).to be user.id
    end
  end
end