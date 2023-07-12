# frozen_string_literal: true

FactoryBot.define do
  factory :tfc_mdm_membership_agreement, class: Tfc::Mdm::MembershipAgreement do
    association :person, factory: :tfc_mdm_person
    association :club, factory: :tfc_mdm_club
    salutation  { "Frau" }
    firstname   { "Jane" }
    lastname    { "Doe" }
    street      { "Musterstr. 20" }
    zipcode     { "60313" }
    city        { "Frankfurt am Main" }
    country     { "DE" }
    birthdate   { 30.years.ago }
    phone       { "+49 123 4567890" }
    email       { "jane.doe@example.com" }
    entry_at    { 1.day.ago }
  end
end
