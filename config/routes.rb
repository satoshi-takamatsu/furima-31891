Rails.application.routes.draw do
  get 'buyers/index'
  devise_for :users

  root to:'items#index'
  
  # resources :items, only: [:index, :new, :create, :show, :edit, :update] do
    # binding.pry
    # delete 'items/:id' => 'items#destroy'
  resources :items do
    resources :buyers, only: [:index, :new, :create]
  end
end
