class ProxiesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :assign_user
  before_action :assign_proxy
  before_action :assign_result
  before_action :set_headers

  def get
    render json: @result.body, status: @result.code
  end

  def post
    render json: @result.body, status: @result.code
  end

  def put
    render json: @result.body, status: @result.code
  end

  def patch
    render json: @result.body, status: @result.code
  end

  def delete
    render json: @result.body, status: @result.code
  end

  def options
  end

  private

  def assign_proxy
    @proxy ||= @user.proxies.find_by(slug: params[:proxy_slug])
  end

  def assign_user
    @user = User.find_by(slug: params[:user_slug])
  end

  def assign_result
    @result = ProxyRequest.new(@proxy, params).run!
  end

  def set_headers
    headers['Access-Control-Allow-Origin'] = @proxy.cors_hosts.map(&:host).join(',')
    headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS'
    headers['Access-Control-Request-Method'] = '*'
    headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
  end
end
