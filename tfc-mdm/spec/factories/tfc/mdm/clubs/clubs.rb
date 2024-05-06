# frozen_string_literal: true

FactoryBot.define do
  factory :tfc_mdm_clubs_club, class: Tfc::Mdm::Clubs::Club do
    association :establishment, factory: :tfc_mdm_establishment
    sequence(:name) { |i| "Club ##{i}" }
  end
end
