# frozen_string_literal: true

require "rails_helper"

RSpec.describe "/de/backend/vereinsstammdaten/people", type: :feature do
  let(:resource_class) { Tfc::Mdm::Person }
  let(:resource) { create(:tfc_mdm_person) }
  let(:resources) { create_list(:tfc_mdm_person, 3) }
  let(:attributes) { attributes_for(:tfc_mdm_person) }

  # List
  it { resources; expect(subject).to implement_index_action(self) }

  # Create
  it {
    expect(subject).to implement_create_action(self)
      .for(resource_class)
      .within_form("#new_person") {
        # fill the needed form inputs via capybara here
        #
        # Example:
        #
        #     select 'de', from: 'slider[locale]'
        #     fill_in 'slider[name]', with: 'My first slider'
        #     check 'slider[auto_start]'
        #     fill_in 'slider[interval]', with: '3'
        fill_in "person[salutation]", with: attributes[:salutation]
        fill_in "person[firstname]", with: attributes[:firstname]
        fill_in "person[lastname]", with: attributes[:lastname]
        fill_in "person[birthdate]", with: attributes[:birthdate]
      }
      .increasing { Tfc::Mdm::Person.count }.by(1)
  }

  # Read
  it { expect(subject).to implement_show_action(self).for(resource) }

  # Update
  it {
    expect(subject).to implement_update_action(self)
      .for(resource)
      .within_form(".edit_person") {
        # fill the needed form inputs via capybara here
        #
        # Example:
        #
        #     fill_in 'slider[name]', with: 'New name'
        fill_in "person[lastname]", with: "a new lastname"
      }
      .updating
      .from(resource.attributes)
      .to("lastname" => "a new lastname") # Example: .to({ 'name' => 'New name' })
  }

  # Delete
  it {
    expect(subject).to implement_delete_action(self)
      .for(resource)
      .reducing { resource_class.count }.by(1)
  }
end
