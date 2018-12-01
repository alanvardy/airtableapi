Rails.application.routes.draw do
  root 'equipment#all'
  get 'equipment/all'
  get 'equipment/:id', to:'equipment#show'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
