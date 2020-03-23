class Api::WidgetsController < ApplicationController
  def index
    res = ShowoffApiWrapper.get('/api/v1/widgets/visible', {}, term_params)
    if res['code'] == 0
      response = res['data']['widgets'].to_json
      render json: response, status: :ok
    else
      response = []
      render json: response, status: :unprocessable_entity
    end

  end

  private
  def term_params
    params.permit(:term)
  end
end