class SessionsController < ApplicationController
  def new
  end


  def create
    auth = request.env['omniauth.auth']
 
    if session[:user_id]
      # Means our user is signed in. Add the authorization to the user
      user = User.find(session[:user_id])
      user.authorizations.find_or_create_by_provider_and_uid(auth['provider'], auth['uid'])
    else
      # Log him in or sign him up
      auth = Authorization.find_or_create(auth)
 
      # Create the session
      session[:user_id] = auth.user.id
    end
    
    redirect_to User.find(session[:user_id])
  end

  def failure
    render :text => "Sorry, but you didn't allow access to our app!"
  end
  
  def destroy
    session[:user_id] = nil
    render :text => "You've logged out!"
  end
  
  private
end
