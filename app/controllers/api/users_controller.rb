module Api
  class UsersController < BaseController
    before_action :set_user

    def follow
      @current_user.follow(@user)
      responder(:ok, "You're now following #{@user.name}")
    end

    def unfollow
      @current_user.unfollow(@user)
      responder(:ok, "You're now unfollow #{@user.name}")
    end

    def sleep_records
      records = current_user.following_sleep_records_past_week
      responder(:ok, 'OK', data: records)
    end

    private

    def set_user
      @user = User.find(params[:user_id])
    end
  end
end
