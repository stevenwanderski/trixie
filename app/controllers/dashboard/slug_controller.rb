class Dashboard::SlugController < AuthenticatedController
  def edit
    assign_host
  end

  def update
    if current_user.update(user_params)
      redirect_to dashboard_proxy_wizard_step_one_path, notice: "Great! Let's create a proxy now."
    else
      assign_host
      render :edit
    end
  end

  private

  def assign_host
    @host = ENV['APP_HOST']
  end

  def user_params
    params.require(:user).permit(:slug)
  end
end
