class ProxiesController < AuthenticatedController
  def show
    response = ProxyRequest.new(params).run!

    render json: response.body, response.code
  end
end
