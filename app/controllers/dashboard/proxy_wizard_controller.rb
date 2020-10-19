class Dashboard::ProxyWizardController < AuthenticatedController
  def step_one
    @proxy = Proxy.new
  end

  def step_two
    @proxy = current_user.proxies.find(params[:id])
    @host = ENV['APP_HOST']
    @slug = current_user.slug
  end

  def step_three
    @proxy = current_user.proxies.find(params[:id])
  end

  def step_four
    @proxy = current_user.proxies.find(params[:id])
  end

  def create
    @proxy = Proxy.new(proxy_params)
    @proxy.user = current_user

    if @proxy.save
      redirect_to dashboard_proxy_wizard_step_two_path(@proxy)
    else
      flash[:error] = 'Proxy could not be saved. Check below.'
      render :step_name
    end
  end

  def update
    @proxy = current_user.proxies.find(params[:id])

    if @proxy.update(proxy_params)

      path = case params[:step]
        when '2'
          dashboard_proxy_wizard_step_three_path
        when '3'
          dashboard_proxy_wizard_step_four_path
        when '4'
          edit_dashboard_proxy_path(@proxy)
        end

      redirect_to path
    else
      flash[:error] = 'Proxy could not be saved. Check below.'
      render :edit
    end
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
      cors_hosts_attributes: [
        :id,
        :host,
        :_destroy
      ],
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
