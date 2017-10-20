Rails.application.routes.draw do
  root to: 'unsorted_messages#index'

  resources :unsorted_messages do
    put :accept, on: :member
    put :reject, on: :member
    get :reload_collection, on: :collection
    get :detect_new_messages, on: :collection
  end

  resources :whitelist_messages

  namespace 'auth' do
    get 'sign_in' => 'sessions#new'
    post 'sign_in' => 'sessions#create'

    get 'sign_out' => 'sessions#destroy'
  end

  get 'get_messages' => 'whitelist_messages#get_messages'

end
