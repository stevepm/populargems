class SessionsController < ApplicationController
  def create
    auth = request.env['omniauth.auth']
    user = User.find_by_provider_and_uid(auth['provider'], auth['uid']) || User.create_with_omniauth(auth)
    log_in(user)
    redirect_to root_url, :notice => 'Signed in!'
  end

  def destroy
    log_out
    redirect_to :back, :notice => 'Signed out!'
  end

end
