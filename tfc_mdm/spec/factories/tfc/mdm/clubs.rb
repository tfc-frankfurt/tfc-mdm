# frozen_string_literal: true

FactoryBot.define do
  factory :tfc_mdm_club, class: Tfc::Mdm::Club do
    association :establishment, factory: :tfc_mdm_establishment
    name { "Verein e.V." }
  end
end
