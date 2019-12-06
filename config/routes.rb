Rails.application.routes.draw do
  
  get '/activities/:id/assign', to: 'activities#assign', as: 'assign_activity'
  get '/activities/:id/complete', to: 'activities#complete', as: 'complete_activity'
  get '/activities/user_assigned', to: 'activities#user_assigned', as: 'user_activities'

  resources :activities
  devise_for :users
  resources :users, only: [:index, :edit, :update] 
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
