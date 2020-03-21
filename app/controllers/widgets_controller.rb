class WidgetsController < ApplicationController
  layout "authenticated"
  def index
    res = ShowoffApiWrapper.get('/api/v1/widgets/visible', {'Authorization' => "Bearer #{session[:current_user]['token']['access_token']}"})
    if res['code'] == 0
      @widgets = res['data']['widgets']
    else
      alert[:danger] = 'error happend when retrieving widgets, try again'
    end
    render :index
  end
end