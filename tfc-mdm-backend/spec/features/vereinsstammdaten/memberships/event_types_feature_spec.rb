require "rails_helper"

RSpec.describe "/de/backend/vereinsstammdaten/memberships/event_types", type: :feature do
  let(:resource_class) { Tfc::Mdm::Memberships::EventType }
  let(:resource) { create(:tfc_mdm_memberships_event_type) }
  let(:resources) { create_list(:tfc_mdm_memberships_event_type, 3) }

  # List
  it { resources; expect(subject).to implement_index_action(self) }

  # Create
  it do
    expect(subject).to implement_create_action(self)
      .for(resource_class)
      .within_form("#new_memberships_event_type") {
        fill_in "memberships_event_type[identifier]", with: "Foo"
      }.increasing { resource_class.count }.by(1)
  end

  # Read
  it { expect(subject).to implement_show_action(self).for(resource) }

  # Update
  it do
    expect(subject).to implement_update_action(self)
      .for(resource)
      .within_form(".edit_memberships_event_type") {
        fill_in "memberships_event_type[identifier]", with: "Bar"
      }.updating
      .from(resource.attributes)
      .to({ "identifier" => "Bar" })
  end

  # Delete
  it do
    expect(subject).to implement_delete_action(self)
      .for(resource)
      .reducing { resource_class.count }.by(1)
  end
end
