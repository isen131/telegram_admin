Rails.application.routes.draw do
  root to: 'unsorted_messages#index'

  resources :unsorted_messages
end
