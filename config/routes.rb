Rails.application.routes.draw do
  namespace :api do
    resources :sleep_trackers, path: :sleeps, only: %i[index show] do
      collection do
        post :clock_in
        post :clock_out
      end
    end

    resources :users, only: [] do
      post :follow
      post :unfollow
    end
  end
end
