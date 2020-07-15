class ProxiesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def get
    response = ProxyRequest.new(params).run!

    render json: response.body, status: response.code
  end

  def post
    user = User.find_by(slug: params[:user_slug])
    proxy = user.proxies.find_by(slug: params[:proxy_slug])

    response = ProxyRequest.new(proxy, params).run!

    render json: response.body, status: response.code
  end
end
