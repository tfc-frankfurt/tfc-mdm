# frozen_string_literal: true

FactoryBot.define do
  factory :tfc_mdm_branch, class: Tfc::Mdm::Branch do
    association :club, factory: :tfc_mdm_club
    sequence :identifier
    valid_from { 1.year.ago }
    valid_to   { "9999-12-31" }
  end
end
