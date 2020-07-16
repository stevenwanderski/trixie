class Dashboard::SettingsController < AuthenticatedController
  def index
    @user = current_user
  end

  def update
    @user = current_user

    if @user.update(user_params)
      flash[:notice] = 'Settings saved!'
      redirect_to dashboard_settings_path
    else
      flash[:error] = 'Could not save settings. Check below.'
      render :index
    end
  end

  private

  def user_params
    params.require(:user).permit(:slug)
  end
end
