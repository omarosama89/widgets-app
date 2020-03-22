class AuthenticationController < ApplicationController
  def new

  end
  def create
    res = ShowoffApiWrapper.post('/oauth/token', login_params.merge(grant_type: 'password'), {"Content-Type" => 'application/json'})
    if res['code'] == 0
      set_current_user(res['data'])

    else
      flash[:danger] = 'failed to login'
      render :new
    end
  end

  def revoke
    res = ShowoffApiWrapper.post('/oauth/revoke', {token: session[:current_user]['token']['access_token']}, {"Content-Type" => 'application/json', 'Authorization' => "Bearer #{session[:current_user]['token']['access_token']}"})
    if res['code'] == 0
      flash[:success] = 'User successfully logged out.'
      unset_curent_user!
    else
      flash[:danger] = 'User failed to log out.'
    end
    redirect_to widgets_path, status: 301
  end

  private
  def login_params
    params.require(:user).permit(:username, :password)
  end
end