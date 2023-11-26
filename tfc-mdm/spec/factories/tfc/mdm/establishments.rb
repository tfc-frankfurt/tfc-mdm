# frozen_string_literal: true

FactoryBot.define do
  factory :tfc_mdm_establishment, class: Tfc::Mdm::Establishment do
    sequence(:name) { |i| "Club #{i}" }
    happened_at      { 1.year.ago }
    sequence(:line1) { |i| "Club #{i} e.V." }
    street           { "Musterstr. 20" }
    zipcode          { "60439" }
    city             { "Frankfurt am Main" }
    country          { "DE" }
  end
end
