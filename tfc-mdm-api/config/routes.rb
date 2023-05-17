Tfc::Mdm::Api::Engine.routes.draw do
  resources :create_person_from_membership_agreement_service, only: [:new, :create]
  resources :create_club_from_establishment_service, only: [:new, :create]
  resources :notify_about_new_membership_agreement_service, only: [:new, :create]

  resources :establishments
  resources :branches
  resources :clubs do
    get :autocomplete, on: :collection
  end
  resources :membership_agreements
  resources :membership_cancellations
  resources :people do
    get :autocomplete, on: :collection
  end

  namespace :addresses do
    resources :addresses
    resources :locations
    resources :roles
  end

  namespace :achievements do
    resources :categories
    resources :achievements do
      post :reposition, on: :member
      post :toggle_published, on: :member
    end
  end

  namespace :positions do
    resources :positions
    resources :entries
    resources :exits
  end
end
