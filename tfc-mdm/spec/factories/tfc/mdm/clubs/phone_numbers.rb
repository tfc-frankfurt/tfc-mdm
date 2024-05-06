FactoryBot.define do
  factory :tfc_mdm_clubs_phone_number, class: 'Tfc::Mdm::Clubs::PhoneNumber' do
    association(:club, factory: :tfc_mdm_clubs_club)
    role { "MyString" }
    number { "MyString" }
  end
end
