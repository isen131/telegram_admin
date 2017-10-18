Rails.application.routes.draw do
  root to: 'unsorted_messages#index'

  resources :unsorted_messages

  namespace 'auth' do
    get 'sign_in' => 'sessions#new'
    post 'sign_in' => 'sessions#create'

    delete 'sign_out' => 'sessions#destroy'
  end

end
