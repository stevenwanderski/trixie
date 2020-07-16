class Dashboard::SettingsController < AuthenticatedController
  def index
    @token = current_user.token
    @user = current_user
  end

  def update
    current_user.update!(user_params)

    redirect_to dashboard_settings_path
  end

  private

  def user_params
    params.require(:user).permit(:slug)
  end
end
