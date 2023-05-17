FactoryBot.define do
  factory :tfc_mdm_achievements_category, class: 'Tfc::Mdm::Achievements::Category' do
    association(:club, factory: :tfc_mdm_club)
    name_de { "1. Platz in der Landesliga" }
    name_en { "1st place in the state league" }
  end
end
