# frozen_string_literal: true

FactoryBot.define do
  factory :tfc_mdm_addresses_address, class: 'Tfc::Mdm::Addresses::Address' do
    association :record, factory: :tfc_mdm_club
    association :role, factory: :tfc_mdm_addresses_role
    line1 { "Jane Doe" }
    street { "Heddernheimer Landstr. 100" }
    zipcode { "60439" }
    city { "Frankfurt am Main" }
    country { "DE" }
  end
end
