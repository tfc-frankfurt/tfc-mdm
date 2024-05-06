FactoryBot.define do
  factory :tfc_mdm_memberships_membership, class: 'Tfc::Mdm::Memberships::Membership' do
    association(:club, factory: :tfc_mdm_clubs_club)
    association(:person, factory: :tfc_mdm_person)
    association(:category, factory: :tfc_mdm_memberships_category)
  end
end
