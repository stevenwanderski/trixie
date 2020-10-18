class Dashboard::SlugController < AuthenticatedController
  def edit
    ap current_user.errors[:slug]
    @host = ENV['APP_HOST']
  end

  def update
    if current_user.update(user_params)
      redirect_to dashboard_proxies_path, notice: 'URL was saved! Now try creating your first proxy 🤗'
    else
      @host = ENV['APP_HOST']
      # flash.now[:error] = 'Could not save.'
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:slug)
  end
end
