class ProxiesController < ApplicationController
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
      redirect_to proxies_path, notice: 'Proxy created.'
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
      redirect_to proxies_path, notice: 'Proxy updated.'
    else
      render :edit
    end
  end

  def destroy
    @proxy = current_user.proxies.find(params[:id])
    @proxy.destroy!

    redirect_to proxies_path, notice: 'Proxy deleted.'
  end

  private

  def proxy_params
    params.require(:proxy).permit(:name, :proxy_url, :target_url)
  end
end
