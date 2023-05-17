# frozen_string_literal: true

FactoryBot.define do
  factory :tfc_mdm_addresses_role, class: 'Tfc::Mdm::Addresses::Role' do
    sequence(:identifier) { |i| "role_#{i}" }
  end
end
