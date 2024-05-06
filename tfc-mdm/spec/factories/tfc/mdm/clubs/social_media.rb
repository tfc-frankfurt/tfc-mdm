FactoryBot.define do
  factory :tfc_mdm_clubs_social_medium, class: 'Tfc::Mdm::Clubs::SocialMedium' do
    association(:club, factory: :tfc_mdm_clubs_club)
    platform { "MyString" }
    url { "MyString" }
    handle { "MyString" }
  end
end
