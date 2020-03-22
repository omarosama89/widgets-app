class UsersController < ApplicationController
  def new

  end
  def create
    res = ShowoffApiWrapper.post('/api/v1/users', {user: user_params}, "Content-Type" => 'application/json')
    if res['code'] == 0
      flash[:success] = 'User created successfully, you can now login.'
      redirect_to widgets_path, status: 301
    else
      flash[:danger] = res['message']
      redirect_to widgets_path, status: 301
    end
  end

  def update
    res = ShowoffApiWrapper.put('/api/v1/users/me', {user: user_update_params}, {"Content-Type" => 'application/json', 'Authorization' => "Bearer #{session[:current_user]['token']['access_token']}"})
    if res['code'] == 0
      flash[:success] = 'User updated successfully'
    else
      flash[:danger] = 'Failed to update user'
    end
  end

  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :password, :email, :image_url)
  end

  def user_update_params
    params.require(:user).permit(:first_name, :last_name, :date_of_birth, :image_url)
  end
end