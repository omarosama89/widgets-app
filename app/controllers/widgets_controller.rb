class WidgetsController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    res = ShowoffApiWrapper.get('/api/v1/widgets/visible', {})
    if res['code'] == 0
      @widgets = res['data']['widgets']
    else
      alert[:danger] = 'error happend when retrieving widgets, try again'
    end
  end

  def user_index
    res = ShowoffApiWrapper.get("/api/v1/users/#{index_user_widgets_params[:user_id]}/widgets", {'Authorization' => "#{session[:current_user]['token']['token_type']} #{session[:current_user]['token']['access_token']}"})
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

  def list_widgets
    res = ShowoffApiWrapper.get('/api/v1/widgets', {'Authorization' => "#{session[:current_user]['token']['token_type']} #{session[:current_user]['token']['access_token']}"})
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

  def edit
    @widget = edit_widget_params
  end

  def update
    res = ShowoffApiWrapper.put("/api/v1/widgets/#{edit_widget_params[:id]}", {widget: widget_params}, {'Content-Type' => 'application/json', 'Authorization' => "#{session[:current_user]['token']['token_type']} #{session[:current_user]['token']['access_token']}"})
    if res['code'] == 0
      flash[:success] = 'Widget updated successfully.'
      redirect_to my_widgets_widgets_path, status: 301
    else
      flash[:danger] = 'failed to update widget. Required field/s may be empty.'
      @widget = widget_params.merge(id: edit_widget_params[:id])
      render :edit
    end
  end

  def destroy
    res = ShowoffApiWrapper.delete("/api/v1/widgets/#{delete_widget_params[:id]}", {'Content-Type' => 'application/json', 'Authorization' => "#{session[:current_user]['token']['token_type']} #{session[:current_user]['token']['access_token']}"})
    if res['code'] == 0
      flash[:success] = 'Widget successfully deleted.'
    else
      flash[:danger] = res['message']
    end
    redirect_to my_widgets_widgets_path, status: 301
  end

  private

  def widget_params
    params.require(:widget).permit(:name, :description, :kind)
  end

  def edit_widget_params
    params.permit(:id, :name, :description)
  end

  def delete_widget_params
    params.permit(:id)
  end

  def index_user_widgets_params
    params.permit(:user_id)
  end
end