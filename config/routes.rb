Rails.application.routes.draw do
  namespace :api do
    resources :sleep_trackers, path: :sleeps

    resources :users do
      post :follow
      post :unfollow
    end
  end
end
