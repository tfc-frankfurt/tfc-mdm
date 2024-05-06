FactoryBot.define do
  factory :tfc_mdm_clubs_email_address, class: 'Tfc::Mdm::Clubs::EmailAddress' do
    association(:club, factory: :tfc_mdm_clubs_club)
    role { "MyString" }
    email { "MyString" }
  end
end
