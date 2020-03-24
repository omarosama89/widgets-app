class ApplicationController < ActionController::Base

  def authenticate_user!
    unless session[:current_user]
      flash[:danger] = 'You have to login before visiting this page.'
      redirect_to widgets_path
    end
  end

  def set_current_user(user_data)
    res = ShowoffApiWrapper.get('/api/v1/users/me', {"Authorization" => "#{user_data['token']['token_type']} #{user_data['token']['access_token']}"})
    session[:current_user] = user_data.merge(res['data'])
  end

  def unset_curent_user!
    session[:current_user] = nil
  end
end
