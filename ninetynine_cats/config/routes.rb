Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :cats do
    resources :cat_rental_requests, only: [:new]
  end

  resources :cat_rental_requests, only: [:create] do
    member do
      post :approve
      post :deny
    end
  end
end
