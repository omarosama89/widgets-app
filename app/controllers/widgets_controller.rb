class WidgetsController < ApplicationController
  def index
    res = ShowoffApiWrapper.get('/api/v1/widgets/visible', {})
    if res['code'] == 0
      @widgets = res['data']['widgets']
    else
      alert[:danger] = 'error happend when retrieving widgets, try again'
    end
  end

  def my_widgets
    res = ShowoffApiWrapper.get('/api/v1/users/me/widgets', {'Authorization' => "#{session[:current_user]['token']['token_type']} #{session[:current_user]['token']['access_token']}"})
    if res['code'] == 0
      @widgets = res['data']['widgets']
    else
      alert[:danger] = 'error happend when retrieving widgets, try again'
    end
  end
end