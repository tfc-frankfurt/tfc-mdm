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

  #  # Create
  #  it {
  #    sign_in(user)
  #    tfc_mdm_positions_position
  #    tfc_mdm_person
  #    expect(subject).to implement_create_action(self)
  #      .for(resource_class)
  #      .within_form("#new_positions_entry") {
  #        # fill the needed form inputs via capybara here
  #        #
  #        # Example:
  #        #
  #        #     select 'de', from: 'slider[locale]'
  #        #     fill_in 'slider[name]', with: 'My first slider'
  #        #     check 'slider[auto_start]'
  #        #     fill_in 'slider[interval]', with: '3'
  #        select tfc_mdm_club.human, from: "positions_entry[club_id]"
  #        select tfc_mdm_positions_position.human, from: "positions_entry[position_id]"
  #        select tfc_mdm_person.class.model_name.human, from: "positions_entry[positionable_type]"
  #        find("#select2-positions_entry_positionable_id-container").click
  #        select tfc_mdm_person.fullname, from: "positions_entry_positionable_id"
  #      }
  #      .increasing {  Tfc::Mdm::Positions::Entry.count }.by(1)
  #  }

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
