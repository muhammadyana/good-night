Rails.application.routes.draw do
  namespace :api do
    resources :sleep_trackers, path: :sleeps
  end
end
