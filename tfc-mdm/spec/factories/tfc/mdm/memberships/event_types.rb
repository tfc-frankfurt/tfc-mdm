FactoryBot.define do
  factory :tfc_mdm_memberships_event_type, class: 'Tfc::Mdm::Memberships::EventType' do
    sequence(:identifier) { |i| "event-type-#{i}" }
  end
end
