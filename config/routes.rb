Rails.application.routes.draw do
  resources :bookings do
    collection do
      get :search
      get :new_reservation

    end
  end
  resources :rooms do
    collection do
      get :search
      get :view_reservation
    end
  end

  resources :users do
    collection do
      post :login
      get :new_user
      get :logout
      get :search
      get :view_reservation
    end
  end

  root 'users#main'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
