# frozen_string_literal: true

require "rails_helper"

RSpec.describe "/de/backend/vereinsstammdaten/clubs", type: :feature do
  let(:resource_class) { Tfc::Mdm::Club }
  let(:resource) { create(:tfc_mdm_club) }
  let(:resources) { create_list(:tfc_mdm_club, 3) }

  let(:tfc_mdm_establishment) { create(:tfc_mdm_establishment) }

  # List
  it { resources; expect(subject).to implement_index_action(self) }

  # Create
  it {
    tfc_mdm_establishment
    expect(subject).to implement_create_action(self)
      .for(resource_class)
      .within_form("#new_club") {
        # fill the needed form inputs via capybara here
        #
        # Example:
        #
        #     select 'de', from: 'slider[locale]'
        #     fill_in 'slider[name]', with: 'My first slider'
        #     check 'slider[auto_start]'
        #     fill_in 'slider[interval]', with: '3'
        select tfc_mdm_establishment.name, from: "club[establishment_id]"
      }
      .increasing { Tfc::Mdm::Club.count }.by(1)
  }

  # Read
  it { expect(subject).to implement_show_action(self).for(resource) }

  # Update
  it {
    expect(subject).to implement_update_action(self)
      .for(resource)
      .within_form(".edit_club") {
        # fill the needed form inputs via capybara here
        #
        # Example:
        #
        #     fill_in 'slider[name]', with: 'New name'
        fill_in "club[name]", with: "New name"
      }
      .updating
      .from(resource.attributes)
      .to("name" => "New name") # Example: .to({ 'name' => 'New name' })
  }

  # Delete
  it {
    expect(subject).to implement_delete_action(self)
      .for(resource)
      .reducing { resource_class.count }.by(1)
  }
end
