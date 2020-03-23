class AuthenticationController < ApplicationController
  def new

  end

  def create
    res = ShowoffApiWrapper.post('/oauth/token', login_params.merge(grant_type: 'password'), {"Content-Type" => 'application/json'})
    if res['code'] == 0
      set_current_user(res['data'])
      flash[:success] = 'Welcome back.'
      redirect_to my_widgets_widgets_path, status: 301
    else
      flash[:danger] = 'failed to login'
      render :new
    end
  end

  def refresh
    res = ShowoffApiWrapper.post('/oauth/token', {grant_type: 'refresh_token', refresh_token: session[:current_user]['token']['refresh_token']}, {"Content-Type" => 'application/json', 'Authorization' => "#{session[:current_user]['token']['token_type']} #{session[:current_user]['token']['access_token']}"})
    if res['code'] == 0
      set_current_user(res['data'])
      flash[:success] = 'Toekn is successfully refreshed'
      redirect_to my_widgets_widgets_path, status: 301
    else
      flash[:danger] = 'failed to refresh token'
      render :new
    end
  end

  def revoke
    res = ShowoffApiWrapper.post('/oauth/revoke', {token: session[:current_user]['token']['access_token']}, {"Content-Type" => 'application/json', 'Authorization' => "#{session[:current_user]['token']['token_type']} #{session[:current_user]['token']['access_token']}"})
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