Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "registrations" }

  get '/notifications', to: 'profiles#notifications'

  get '/accept/:id',					to: 'friendship#accept', 	as: 'friend_accept'
  get '/decline/:id',					to: 'friendship#decline',	as: 'friend_decline'
 	#post '/friend_request/:id', to: 'friendship#request', as: 'friend_request'

 	resources :friendship, only: [:create]

  resources :posts do
	  resources :comments
	  resources :likes
	end

	resources :profiles, except: :destroy
	resources :addresses, only: [:new, :create, :edit, :update]

	root "posts#index" # citiation >"set to 'something' " from devise
end
