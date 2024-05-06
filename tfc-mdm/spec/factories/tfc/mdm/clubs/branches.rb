# frozen_string_literal: true

FactoryBot.define do
  factory :tfc_mdm_clubs_branch, class: Tfc::Mdm::Clubs::Branch do
    association(:club, factory: :tfc_mdm_clubs_club)
    sequence(:identifier) { |i| "branch_#{i}" }
    valid_from { 1.year.ago }
    valid_to   { "9999-12-31" }
  end
end
