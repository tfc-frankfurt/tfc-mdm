require "rails_helper"

RSpec.describe "/de/backend/vereinsstammdaten/positions/positions", type: :feature do
  let(:resource_class) { Tfc::Mdm::Positions::Position }
  let(:resource) { create(:tfc_mdm_positions_position) }
  let(:resources) { create_list(:tfc_mdm_positions_position, 3) }

  let(:club) { create(:tfc_mdm_club) }

  # List
  it { resources; expect(subject).to implement_index_action(self) }

  # Create
  it do
    club
    expect(subject).to implement_create_action(self)
      .for(resource_class)
      .within_form("#new_positions_position") {
        # fill the needed form inputs via capybara here
        #
        # Example:
        #
        #     fill_in 'slider[name]', with: 'New name'
        select club.human, from: "positions_position[club_id]"
        fill_in "positions_position[name_de]", with: "Verein e.V."
        fill_in "positions_position[name_en]", with: "Verein e.V."
      }.increasing { resource_class.count }.by(1)
  end

  # Read
  it { expect(subject).to implement_show_action(self).for(resource) }

  # Update
  it do
    expect(subject).to implement_update_action(self)
      .for(resource)
      .within_form(".edit_positions_position") {
        # fill the needed form inputs via capybara here
        #
        # Example:
        #
        #     fill_in 'slider[name]', with: 'New name'
        fill_in "positions_position[name_de]", with: "Neuer Verein e.V."
      }.updating
      .from(resource.attributes)
      .to("name_de" => "Neuer Verein e.V.") # Example: .to({ 'name' => 'New name' })
  end

  # Delete
  it do
    expect(subject).to implement_delete_action(self)
      .for(resource)
      .reducing { resource_class.count }.by(1)
  end
end
