Rails.application.routes.draw do
  resources :profile_types
  resources :accounts
  resources :sessions, only: [:destroy, :new, :create] 
  get '/home', to: 'static_pages#home', as: 'home'
  get '/about', to: 'static_pages#about', as: 'about'
  get '/contact', to: 'static_pages#contact', as: 'contact'

  get '/account/verify',  to: 'accounts#verify', as: 'verify'
  get '/account/resend_verify',  to: 'accounts#do_send_verification_email', as: 'resend_verify'

  get '/signup',  to: 'accounts#new', as: 'signup'
  get '/signin',  to: 'sessions#new', as: 'signin'
  match '/signout', to: 'sessions#destroy', as: 'signout', via: 'delete'
  #root "users#index"
  root 'static_pages#home'

  get '*path' => redirect('/')
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
