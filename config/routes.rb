Whowonit::Application.routes.draw do
  resources :auctions, :only => [:index, :new, :create, :destroy]

  devise_for :users

  root :to => 'auctions#index'
end
