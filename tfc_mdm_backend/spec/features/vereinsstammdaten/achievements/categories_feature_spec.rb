require "rails_helper"

RSpec.describe "/de/backend/vereinsstammdaten/achievements/categories", type: :feature do
  let(:resource_class) { Tfc::Mdm::Achievements::Category }
  let(:resource) { create(:tfc_mdm_achievements_category) }
  let(:resources) { create_list(:tfc_mdm_achievements_category, 3) }

  let(:club) { create(:tfc_mdm_club) }

  # List
  it { resources; expect(subject).to implement_index_action(self) }

  # Create
  it do
    club
    expect(subject).to implement_create_action(self)
      .for(resource_class)
      .within_form("#new_achievements_category") {
        select club.name, from: "achievements_category[club_id]"
        fill_in "achievements_category[name_de]", with: "Wettbewerb #1"
        fill_in "achievements_category[name_en]", with: "Championship #1"
      }.increasing { resource_class.count }.by(1)
  end

  # Read
  it { expect(subject).to implement_show_action(self).for(resource) }

  # Update
  it do
    club
    expect(subject).to implement_update_action(self)
      .for(resource)
      .within_form(".edit_achievements_category") {
        fill_in "achievements_category[name_de]", with: "Wettbewerb #2"
      }.updating
      .from(resource.attributes)
      .to({ "name_de" => "Wettbewerb #2" })
  end

  # Delete
  it do
    expect(subject).to implement_delete_action(self)
      .for(resource)
      .reducing { resource_class.count }.by(1)
  end
end
