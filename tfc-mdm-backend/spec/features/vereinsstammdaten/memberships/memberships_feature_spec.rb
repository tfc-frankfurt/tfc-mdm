require "rails_helper"

RSpec.describe "/de/backend/vereinsstammdaten/memberships/memberships", type: :feature do
  let(:resource_class) { Tfc::Mdm::Memberships::Membership }
  let(:resource) { create(:tfc_mdm_memberships_membership) }
  let(:resources) { create_list(:tfc_mdm_memberships_membership, 3) }

  let(:category) { create(:tfc_mdm_memberships_category) }
  let(:club) { create(:tfc_mdm_club) }
  let(:person) { create(:tfc_mdm_person) }

  # List
  it { resources; expect(subject).to implement_index_action(self) }

  # Create
  it do
    club
    category
    person
    expect(subject).to implement_create_action(self)
      .for(resource_class)
      .within_form("#new_memberships_membership") {
        select club.human, from: "memberships_membership[club_id]"
        select category.human, from: "memberships_membership[category_id]"
        select person.human, from: "memberships_membership[person_id]"

        fill_in "memberships_membership[active_from]", with: 1.year.ago.strftime("%d.%m.%Y %H:%M:%S")
        fill_in "memberships_membership[active_to]", with: 1.year.from_now.strftime("%d.%m.%Y %H:%M:%S")
      }.increasing { resource_class.count }.by(1)
  end

  # Read
  it { expect(subject).to implement_show_action(self).for(resource) }

  # Update
  it do
    point_in_time = 1.day.from_now.change(usec: 0)
    expect(subject).to implement_update_action(self)
      .for(resource)
      .within_form(".edit_memberships_membership") {
        fill_in "memberships_membership[active_to]", with: point_in_time.strftime("%d.%m.%Y %H:%M:%S")
      }.updating
      .from(resource.attributes)
      .to({ "active_to" => point_in_time })
  end

  # Delete
  it do
    expect(subject).to implement_delete_action(self)
      .for(resource)
      .reducing { resource_class.count }.by(1)
  end
end
