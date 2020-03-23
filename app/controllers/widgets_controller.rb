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

  def create
    res = ShowoffApiWrapper.post('/api/v1/widgets', {widget: widget_params}, {'Content-Type' => 'application/json', 'Authorization' => "#{session[:current_user]['token']['token_type']} #{session[:current_user]['token']['access_token']}"})
    if res['code'] == 0
      flash[:success] = 'Widget successfully created.'
      redirect_to my_widgets_widgets_path, status: 301
    else
      flash[:danger] = res['message']
      render :new
    end
  end

  private

  def widget_params
    params.require(:widget).permit(:name, :description, :kind)
  end
end