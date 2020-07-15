class ProxiesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def get
    response = ProxyRequest.new(params).run!

    render json: response.body, status: response.code
  end

  def post
    response = ProxyRequest.new(params).run!

    render json: response.body, status: response.code
  end
end
