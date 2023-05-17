# frozen_string_literal: true

FactoryBot.define do
  factory :tfc_mdm_establishment, class: Tfc::Mdm::Establishment do
    name        { "Verein e.V." }
    happened_at { 1.year.ago }
    line1       { "Verein e.V." }
    street      { "Musterstr. 20" }
    zipcode     { "60439" }
    city        { "Frankfurt am Main" }
    country     { "DE" }
  end
end
