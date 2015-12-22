module AlertMailerHelper

  def unsubscribe_link
    "https://powerful-earth-9752.herokuapp.com/unsubscribe/#{@user.app_uid}"
  end

end
