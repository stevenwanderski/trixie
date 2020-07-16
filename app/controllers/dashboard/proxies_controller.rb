class Dashboard::ProxiesController < AuthenticatedController
  def index
    @proxies = current_user.proxies.all
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
      flash[:error] = 'Proxy could not be saved. Check below.'
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
      flash[:error] = 'Proxy could not be saved. Check below.'
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
      :proxy_request_type,
      :target_url,
      :target_request_type,
      :body_format,
      :slug,
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
