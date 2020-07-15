class Dashboard::ProxiesController < AuthenticatedController
  def index
    @proxies = current_user.proxies.all

    # url = 'https://jsonplaceholder.typicode.com/posts'
    #
    # response = HTTParty.post(url,
    #   body: { title: 'bar' }.to_json,
    #   headers: {
    #     "Content-type": "application/json; charset=UTF-8"
    #   }
    # )
    #
    # ap JSON.parse(response.body)
  end

  def new
    @proxy = Proxy.new
  end

  def create
    @proxy = Proxy.new(proxy_params)
    @proxy.user = current_user

    if @proxy.save
      redirect_to dashboard_proxies_path, notice: 'Proxy created.'
    else
      render :new
    end
  end

  def edit
    @proxy = current_user.proxies.find(params[:id])
  end

  def update
    @proxy = current_user.proxies.find(params[:id])

    if @proxy.update(proxy_params)
      redirect_to dashboard_proxies_path, notice: 'Proxy updated.'
    else
      render :edit
    end
  end

  def destroy
    @proxy = current_user.proxies.find(params[:id])
    @proxy.destroy!

    redirect_to dashboard_proxies_path, notice: 'Proxy deleted.'
  end

  private

  def proxy_params
    params.require(:proxy).permit(
      :name,
      :proxy_url,
      :target_url,
      :target_request_type,
      :body_format,
      proxy_params_attributes: [
        :id,
        :param_from,
        :param_to,
        :_destroy
      ],
      proxy_headers_attributes: [
        :id,
        :name,
        :value,
        :_destroy
      ]
    )
  end
end
