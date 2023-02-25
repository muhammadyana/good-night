module Api
  class BaseController < ApplicationController
    include ApiHelper

    before_action :authenticate_user!

    def authenticate_user!
      return responder(:unauthorized, 'Please provide user_id in headers') unless request.headers['User-Id']

      @current_user ||= User.find(request.headers['User-Id'])
    end
  end
end
