require "rails_helper"

RSpec.describe "/de/backend/vereinsstammdaten/addresses/roles", type: :feature do
  let(:resource_class) { Tfc::Mdm::Addresses::Role }
  let(:resource) { create(:tfc_mdm_addresses_role) }
  let(:resources) { create_list(:tfc_mdm_addresses_role, 3) }

  let(:club) { create(:tfc_mdm_club) }

  # List
  it { resources; expect(subject).to implement_index_action(self) }

  # Create
  it do
    club
    expect(subject).to implement_create_action(self)
      .for(resource_class)
      .within_form("body") {
        select club.human, from: "addresses_role[club_id]"
        fill_in "addresses_role[identifier]", with: "Foo"
      }.increasing { resource_class.count }.by(1)
  end

  # Read
  it { expect(subject).to implement_show_action(self).for(resource) }

  # Update
  it do
    expect(subject).to implement_update_action(self)
      .for(resource)
      .within_form(".edit_addresses_role") {
        fill_in "addresses_role[identifier]", with: "Bar"
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
