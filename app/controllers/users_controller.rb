class UsersController < ApplicationController

  def create
    res = ShowoffApiWrapper.post('/api/v1/users', {user: user_params}, "Content-Type" => 'application/json')
    if res['code'] == 0
      flash[:success] = 'User created successfully, you can now login.'
    else
      flash[:danger] = res['message']
    end
    redirect_to widgets_path, status: 301
  end

  def update
    res = ShowoffApiWrapper.put('/api/v1/users/me', {user: user_update_params}, {"Content-Type" => 'application/json', 'Authorization' => "#{session[:current_user]['token']['token_type']} #{session[:current_user]['token']['access_token']}"})
    if res['code'] == 0
      flash[:success] = 'User updated successfully'
    else
      flash[:danger] = 'Failed to update user'
    end
  end

  def change_password
    res = ShowoffApiWrapper.post('/api/v1/users/me/password', {user: change_password_params}, {"Content-Type" => 'application/json', 'Authorization' => "#{session[:current_user]['token']['token_type']} #{session[:current_user]['token']['access_token']}"})
    if res['code'] == 0
      flash[:success] = 'Password have been changed successfully. You can Login using the new password'
      unset_curent_user!
      redirect_to widgets_path, status: 301
    else
      flash[:danger] = res['message']
      render :new_change_password
    end
  end

  def reset_password
    res = ShowoffApiWrapper.post('/api/v1/users/reset_password', {user: reset_password_params}, {"Content-Type" => 'application/json'})
    if res['code'] == 0
      flash[:success] = res['message']
    else
      flash[:danger] = res['message']
    end
    redirect_to widgets_path, status: 301
  end

  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :password, :email, :image_url)
  end

  def user_update_params
    params.require(:user).permit(:first_name, :last_name, :date_of_birth, :image_url)
  end

  def change_password_params
    params.require(:user).permit(:current_password, :new_password)
  end

  def reset_password_params
    params.require(:user).permit(:email)
  end
end