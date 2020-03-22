class WidgetsController < ApplicationController
  def index
    res = ShowoffApiWrapper.get('/api/v1/widgets/visible', {})
    if res['code'] == 0
      @widgets = res['data']['widgets']
    else
      alert[:danger] = 'error happend when retrieving widgets, try again'
    end
    render :index
  end
end