class UnsubscribeController < ApplicationController
  
  before_action :load_unsub_user, only: :unsubscribe

  def unsubscribe
    @unsub_user.send_emails = false
    @unsub_user.save!
  end

  private

  def load_unsub_user
    @unsub_user = User.find_by(app_uid: params[:app_uid])
  end

end
