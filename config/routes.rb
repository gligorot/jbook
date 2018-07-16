Rails.application.routes.draw do
  devise_for :users

  get '/notifications', to: 'profiles#notifications'

  get '/accept/:id',		to: 'friendship#accept', 	as: 'friend_accept'
  get '/decline/:id',		to: 'friendship#decline',	as: 'friend_decline'

  resources :posts do
	  resources :comments
	  resources :likes
	end

	root "posts#index" # citiation >"set to 'something' " from devise
end
