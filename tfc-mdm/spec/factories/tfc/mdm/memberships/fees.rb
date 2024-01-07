FactoryBot.define do
  factory :tfc_mdm_memberships_fee, class: 'Tfc::Mdm::Memberships::Fee' do
    association(:category, factory: :tfc_mdm_memberships_category)
    amount { 7.50 }
    active_from { 2.years.ago }
  end
end
