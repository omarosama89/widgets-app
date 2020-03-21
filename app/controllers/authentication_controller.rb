class AuthenticationController < ApplicationController
  layout "authenticated"
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

  private
  def login_params
    params.require(:user).permit(:username, :password)
  end
end