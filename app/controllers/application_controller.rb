class ApplicationController < ActionController::API
  scope :desc, -> { order(created_at: :desc) }
  scope :asc, -> { order(created_at: :asc) }
end
