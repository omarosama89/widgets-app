class Api::UsersController < ApplicationController
  def check_email
    res = ShowoffApiWrapper.get('/api/v1/users/email', {}, check_email_params)
    if res['code'] == 0
      render json: res, status: :ok
    else
      render json: res, status: :unprocessable_entity
    end
  end

  private
  def check_email_params
    params.require(:user).permit(:email)
  end
end