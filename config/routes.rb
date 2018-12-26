Rails.application.routes.draw do
  get 'sites/index'
  get 'sites/show'
  get 'sites/:id', to:'sites#show'
  root 'sites#index'
  get 'equipment/index'
  get 'equipment/:id', to:'equipment#show'

  get '/check.txt', to: proc {[200, {}, ['it_works']]}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
