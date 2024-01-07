require "rails_helper"

RSpec.describe "/de/backend/vereinsstammdaten/memberships/categories", type: :feature do
  let(:resource_class) { Tfc::Mdm::Memberships::Category }
  let(:resource) { create(:tfc_mdm_memberships_category) }
  let(:resources) { create_list(:tfc_mdm_memberships_category, 3) }

  let(:club) { create(:tfc_mdm_club) }

  # List
  it { resources; expect(subject).to implement_index_action(self) }

  # Create
  it do
    club
    expect(subject).to implement_create_action(self)
      .for(resource_class)
      .within_form("body") {
        select club.human, from: "memberships_category[club_id]"
        fill_in "memberships_category[identifier]", with: "Foo"
      }.increasing { resource_class.count }.by(1)
  end

  # Read
  it { expect(subject).to implement_show_action(self).for(resource) }

  # Update
  it do
    expect(subject).to implement_update_action(self)
      .for(resource)
      .within_form(".edit_memberships_category") {
        fill_in "memberships_category[identifier]", with: "Bar"
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
