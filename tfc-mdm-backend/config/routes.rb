# frozen_string_literal: true

Tfc::Mdm::Backend::Engine.routes.draw do
  resources :create_person_from_membership_agreement_service, only: [:new, :create]
  resources :create_club_from_establishment_service, only: [:new, :create]
  resources :notify_about_new_membership_agreement_service, only: [:new, :create]

  resources :establishments
  resources :membership_agreements
  resources :membership_cancellations
  resources :number_ranges
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

  namespace :clubs do
    resources :bank_details
    resources :branches do
      get :autocomplete, on: :collection
    end
    resources :clubs do
      get :autocomplete, on: :collection
    end
    resources :email_addresses
    resources :phone_numbers
    resources :social_media
  end

  namespace :memberships do
    resources :billing_run_services, only: [:new, :create]
    resources :categories
    resources :events
    resources :event_types
    resources :fees
    resources :memberships do
      get :autocomplete, on: :collection
    end
    resources :import_from_membership_agreement_services, only: [:new, :create]
  end

  namespace :positions do
    resources :positions
    resources :entries
    resources :exits
  end

  root to: "home#index"
end
