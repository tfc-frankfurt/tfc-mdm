FactoryBot.define do
  factory :tfc_mdm_memberships_event, class: 'Tfc::Mdm::Memberships::Event' do
    association(:membership, factory: :tfc_mdm_memberships_membership)
    association(:event_type, factory: :tfc_mdm_memberships_event_type)
    happened_at { 1.day.ago }
  end
end
