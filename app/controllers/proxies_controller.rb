class ProxiesController < AuthenticatedController
  def show
    proxy = Proxy.find(params[:id])

    ap "#{proxy.target_request_type.upcase} #{proxy.target_url}"

    render plain: 'OK'
  end
end
