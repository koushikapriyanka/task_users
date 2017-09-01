Rails.application.routes.draw do
  root :to => "homepage#index"
  namespace :admin do
  	root :to => "users#index"
  	resources :users, only: [:index, :edit, :update] 
  	resources :tasks, only: [:index, :edit, :update] do
      collection do
        put :assign_users
        get :pending_approval
      end
    end
  end

  resources :tasks
  devise_for :users, :controllers => { :registrations => 'registrations'}
  resources :users, only: [:index, :create]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
