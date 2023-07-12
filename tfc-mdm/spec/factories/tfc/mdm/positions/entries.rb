FactoryBot.define do
  factory :tfc_mdm_positions_entry, class: 'Tfc::Mdm::Positions::Entry' do
    association(:club, factory: :tfc_mdm_club)
    association(:position, factory: :tfc_mdm_positions_position )
    association(:positionable, factory: :tfc_mdm_person)
    happened_at { 1.year.ago }
    email { 'jane.doe@domain.local' }
    after(:build) do |resource|
      resource.image.attach(
        io: File.open(Tfc::Mdm::Engine.root.join(*%w(spec files tfc mdm positions entry example.jpg))),
        filename: 'example.jpg',
        content_type: 'image/jpeg'
      )
    end
  end
end
