class ApplicationController < ActionController::Base

  def set_current_user(user_data)
    res = ShowoffApiWrapper.get('/api/v1/users/me', {"Authorization" => "#{user_data['token']['token_type']} #{user_data['token']['access_token']}"})
    session[:current_user] = user_data.merge(res['data'])
  end

  def unset_curent_user!
    session[:current_user] = nil
  end
end
