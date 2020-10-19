class Dashboard::ProxyWizardController < AuthenticatedController
  def step_one
    @proxy = Proxy.new
  end

  def step_two
    assign_host
    assign_proxy
    assign_slug
  end

  def step_three
    assign_proxy
  end

  def step_four
    assign_proxy
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
      flash.now[:error] = 'Proxy could not be saved. Check below.'

      case params[:step]
        when '1'
          render :step_one
        when '2'
          assign_host
          assign_slug
          render :step_two
        when '3'
          render :step_three
        when '4'
          render :step_four
        end
    end
  end

  private

  def assign_host
    @host = ENV['APP_HOST']
  end

  def assign_proxy
    @proxy = current_user.proxies.find(params[:id])
  end

  def assign_slug
    @slug = current_user.slug
  end

  def proxy_params
    return {} if params[:proxy].blank?

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
