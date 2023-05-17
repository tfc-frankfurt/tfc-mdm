# frozen_string_literal: true

FactoryBot.define do
  factory :tfc_mdm_person, class: Tfc::Mdm::Person do
    salutation { "Frau" }
    firstname  { "Jane" }
    lastname   { "Doe" }
    birthdate  { 30.years.ago }
  end
end
