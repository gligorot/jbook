Rails.application.routes.draw do
  devise_for :users

  resources :posts do
	  resources :comments
	  resources :likes
	end

	root "posts#index" # citiation >"set to 'something' " from devise
end
