# frozen_string_literal: true

require "rails_helper"

RSpec.describe "/de/backend/vereinsstammdaten/positions/entries", type: :feature, vcr: true do
  let(:resource_class) { Tfc::Mdm::Positions::Entry }
  let(:resource) { create(:tfc_mdm_positions_entry) }
  let(:resources) { create_list(:tfc_mdm_positions_entry, 3) }

  let(:tfc_mdm_club) { create(:tfc_mdm_club) }
  let(:tfc_mdm_positions_position) { create(:tfc_mdm_positions_position, club: tfc_mdm_club) }
  let(:tfc_mdm_person) { create(:tfc_mdm_person) }

  # List
  it { resources; expect(subject).to implement_index_action(self) }

  # Read
  it { expect(subject).to implement_show_action(self).for(resource) }

  # Update
  it {
    expect(subject).to implement_update_action(self)
      .for(resource)
      .within_form(".edit_positions_entry") {
        # fill the needed form inputs via capybara here
        #
        # Example:
        #
        #     fill_in 'slider[name]', with: 'New name'
        fill_in "positions_entry[email]", with: "jane.doe@domain.local"
      }
      .updating
      .from(resource.attributes)
      .to("email" => "jane.doe@domain.local") # Example: .to({ 'name' => 'New name' })
  }

  # Delete
  it {
    expect(subject).to implement_delete_action(self)
      .for(resource)
      .reducing { resource_class.count }.by(1)
  }
end
