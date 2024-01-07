FactoryBot.define do
  factory :tfc_mdm_memberships_category, class: "Tfc::Mdm::Memberships::Category" do
    association(:club, factory: :tfc_mdm_club)
    sequence(:identifier) { |i| "category-#{i}" }
  end
end
