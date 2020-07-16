class ProxiesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate

  def get
    render json: result.body, status: result.code
  end

  def post
    render json: result.body, status: result.code
  end

  def put
    render json: result.body, status: result.code
  end

  def patch
    render json: result.body, status: result.code
  end

  def delete
    render json: result.body, status: result.code
  end

  private

  def authenticate
    authenticate_or_request_with_http_token do |token, options|
      @user = User.find_by(slug: params[:user_slug])
      ActiveSupport::SecurityUtils.secure_compare(token, @user.token)
    end
  end

  def proxy
    @proxy ||= @user.proxies.find_by(slug: params[:proxy_slug])
  end

  def result
    @result ||= ProxyRequest.new(proxy, params).run!
  end
end
