class ApplicationController < ActionController::Base

  def set_current_user(user_data)
    res = ShowoffApiWrapper.get('/api/v1/users/me', {"Authorization" => "Bearer #{user_data['token']['access_token']}"})
    session[:current_user] = user_data.merge(res['data'])
  end
end
