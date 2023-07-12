FactoryBot.define do
  factory :tfc_mdm_positions_position, class: 'Tfc::Mdm::Positions::Position' do
    association(:club, factory: :tfc_mdm_club)
    name_de { "MyString" }
    name_en { "MyString" }
  end
end
