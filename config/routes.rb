require 'resque/server'
OnoBurrito::Application.routes.draw do
  mount Resque::Server.new, at: "/resque"

  resources :restaurants do
    resources :contacts
    resources :orders
    resources :transactions, only: [:new, :create, :show]
    resources :locations
  end

  resources :orders # TODO: remove this line after update

  root :to => "restaurants#index"

  resources :contacts
  resources :items do
    :item_categories
  end
  resources :locations
  resources :order_items
  resources :sessions
  resources :transactions, only: [:new, :create, :show] # TODO: remove this line after update
  resources :users do
    :stores
  end

  get "code" => "codes#index"
  get "log_out" => "sessions#destroy"
  get "log_in" => "sessions#new"
  get 'menu' => 'items#index', as: :menu
  get "menu/:category_slug" => "items#in_category", as: "menu_items"
  get "sign_up" => "users#new"

end
