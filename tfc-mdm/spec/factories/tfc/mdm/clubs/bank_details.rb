FactoryBot.define do
  factory :tfc_mdm_clubs_bank_detail, class: 'Tfc::Mdm::Clubs::BankDetail' do
    association(:club, factory: :tfc_mdm_clubs_club)
    account_holder { "Donald Duck" }
    bank_name { "DKB" }
    bic { "BYLADEM1001" }
    iban { "DE01234567890123456789" }
    sequence(:role) { |i| "role_#{i}" }
  end
end
