require 'rails_helper'

RSpec.describe 'Friendship', type: :feature, feature: true do
  context 'context' do
    before do
      @user = User.create(email: 'mail@mail.com', name: 'Tester', password: '123456')
      @user2 = User.create(email: 'mail2@mail.com', name: 'Tester2', password: '123456')
      visit 'http://localhost:3000/users/sign_in'
      fill_in 'Email', with: 'mail@mail.com'
      fill_in 'Password', with: '123456'
      click_on 'Log in'
    end
    
    scenario 'log_in valid' do
      expect(page).to have_content('Signed in successfully.')
    end

    scenario 'friend request' do
      visit 'http://localhost:3000/users'
      url = 'http://localhost:3000/friendships/'
      url.concat(@user2.id.to_s)
      visit url
      expect(@user.pending_friends).to include(@user2)
      expect(page).to have_content('Pending request')   
    end

    scenario 'friend request' do
      visit 'http://localhost:3000/users'
      url = 'http://localhost:3000/friendships/'
      url.concat(@user2.id.to_s)
      visit url
      click_on 'Sign out'
      visit 'http://localhost:3000/users/sign_in'
      fill_in 'Email', with: 'mail2@mail.com'
      fill_in 'Password', with: '123456'
      click_on 'Log in'
      visit 'http://localhost:3000/users'
      click_on 'Accept', match: :first
      u_1 = User.find(@user.id.to_s)
      expect(u_1.friends).to include(@user2)
      expect(page).to have_content('Pending request')   
    end

  end
end