class UsersController < ApplicationController
  def create
    res = ShowoffApiWrapper.post('/api/v1/users', {user: user_params}, "Content-Type" => 'application/json')
    if res['code'] == 0
      flash[:success] = 'User created successfuly, ylou can now login.'
    else
      flash[:danger] = 'User cannot be created, try again.'
    end
    render :new
  end

  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :password, :email, :image_url)
  end
end