module Api
  class BaseController < ApplicationController
    include ApiHelper
    include ActionController::Helpers

    before_action :authenticate_user!

    helper_method :current_user

    private

    def authenticate_user!
      @current_user = User.find_by(id: request.headers['User-Id'])
      return responder(:unauthorized, 'Invalid user') unless @current_user
    end

    attr_reader :current_user
  end
end
