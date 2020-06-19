module UserHelper
  def user_friend_request(user)
    if current_user.friend_requests.include?(user)
      link_to 'accept', accept_path(user)
      link_to 'reject', reject_path(user)
    else
      pending_request(user)
    end
  end
  
  def user_friend(user)
    if current_user.friend?(user)
      'Is you friend'
    else
      user_friend_request(user)
    end
  end

  def pending_request(user)
    if current_user.pending_friends.include?(user)
      "Pending request"
    else
      ('<p><button>' + (link_to 'Friend Request', friend_req_path(user))+ '</button><p>').html_safe
    end
  end
end