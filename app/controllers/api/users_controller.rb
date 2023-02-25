module Api
  class UsersController < BaseController
    before_action :set_user

    def follow
      @current_user.follow(@user)
      responder(:ok, "You're now following #{@user.name}")
    end

    private

    def set_user
      @user = User.find(params[:user_id])
    end
  end
end
