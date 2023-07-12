FactoryBot.define do
  factory :tfc_mdm_positions_exit, class: 'Tfc::Mdm::Positions::Exit' do
    association(:club, factory: :tfc_mdm_club)
    association(:entry, factory: :tfc_mdm_positions_entry )
    happened_at { 1.month.ago }
  end
end
