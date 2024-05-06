# frozen_string_literal: true

Tfc::Mdm::Engine.routes.draw do
  localized do
    scope :tfc_mdm_engine do
      resources :branches, only: [:index, :show]
      namespace :achievements do
        resources :achievements, only: [:index, :show]
      end

      namespace :clubs do
        resources :clubs, only: [:index, :show], path: "/"
        resource :current_club, only: [:show]
      end

      namespace :memberships do
        resources :memberships, only: [:index, :show]
      end

      root to: "branches#index"
    end
  end
end
