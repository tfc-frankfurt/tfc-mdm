# frozen_string_literal: true

require "rails_helper"

RSpec.describe "/de/backend/vereinsstammdaten/branches", type: :feature do
  let(:resource_class) { Tfc::Mdm::Branch }
  let(:resource) { create(:tfc_mdm_branch) }
  let(:resources) { create_list(:tfc_mdm_branch, 3) }

  let(:club) { create(:tfc_mdm_club) }

  # List
  it { resources; expect(subject).to implement_index_action(self) }

  # Create
  it {
    club
    expect(subject).to implement_create_action(self)
      .for(resource_class)
      .within_form("#new_branch") {
        # fill the needed form inputs via capybara here
        #
        # Example:
        #
        #     select 'de', from: 'slider[locale]'
        #     fill_in 'slider[name]', with: 'My first slider'
        #     check 'slider[auto_start]'
        #     fill_in 'slider[interval]', with: '3'
        select club.name, from: "branch[club_id]"
        fill_in "branch[identifier]", with: "branch-1"
        # fill_in 'branch[name]', with: 'Branch #1'
        # fill_in 'branch[description]', with: 'This is the main branch.'
        fill_in "branch[valid_from]", with: Time.zone.now.to_date
        fill_in "branch[valid_to]",   with: "31.12.9999"
      }
      .increasing { Tfc::Mdm::Branch.count }.by(1)
  }

  # Read
  it { expect(subject).to implement_show_action(self).for(resource) }

  # Update
  it {
    expect(subject).to implement_update_action(self)
      .for(resource)
      .within_form(".edit_branch") {
        # fill the needed form inputs via capybara here
        #
        # Example:
        #
        #     fill_in 'slider[name]', with: 'New name'
        fill_in "branch[identifier]", with: "branch-2"
      }
      .updating
      .from(resource.attributes)
      .to("identifier" => "branch-2") # Example: .to({ 'name' => 'New name' })
  }

  # Delete
  it {
    expect(subject).to implement_delete_action(self)
      .for(resource)
      .reducing { resource_class.count }.by(1)
  }
end
