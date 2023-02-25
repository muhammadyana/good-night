module Api
  class UsersController < BaseController
    before_action :set_user, only: %i[follow unfollow]

    def follow
      @current_user.follow(@user)
      responder(:ok, "You're now following #{@user.name}")
    end

    def unfollow
      @current_user.unfollow(@user)
      responder(:ok, "You're now unfollow #{@user.name}")
    end

    private

    def set_user
      @user = User.find(params[:user_id])
    end
  end
end
