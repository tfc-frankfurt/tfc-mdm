FactoryBot.define do
  factory :tfc_mdm_achievements_achievement, class: 'Tfc::Mdm::Achievements::Achievement' do
    association(:club, factory: :tfc_mdm_club)
    association(:category, factory: :tfc_mdm_achievements_category )
    association(:achiever, factory: :tfc_mdm_person)
    happened_at { 1.year.ago }
  end
end
