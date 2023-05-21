# frozen_string_literal: true

require "rails_helper"

RSpec.describe "/de/backend/vereinsstammdaten/establishments", type: :feature do
  let(:resource_class) { Tfc::Mdm::Establishment }
  let(:resource) { create(:tfc_mdm_establishment) }
  let(:resources) { create_list(:tfc_mdm_establishment, 3) }
  let(:attributes) { attributes_for(:tfc_mdm_establishment) }

  # List
  it { resources; expect(subject).to implement_index_action(self) }

  # Create
  it {
    expect(subject).to implement_create_action(self)
      .for(resource_class)
      .within_form("#new_establishment") {
        # fill the needed form inputs via capybara here
        #
        # Example:
        #
        #     select 'de', from: 'slider[locale]'
        #     fill_in 'slider[name]', with: 'My first slider'
        #     check 'slider[auto_start]'
        #     fill_in 'slider[interval]', with: '3'
        fill_in "establishment[name]", with: attributes[:name]
        fill_in "establishment[line1]", with: attributes[:line1]
        fill_in "establishment[street]", with: attributes[:street]
        fill_in "establishment[zipcode]", with: attributes[:zipcode]
        fill_in "establishment[city]", with: attributes[:city]
        select "Deutschland", from: "establishment[country]"
        fill_in "establishment[happened_at]", with: attributes[:happened_at]
      }
      .increasing { Tfc::Mdm::Establishment.count }.by(1)
  }

  # Read
  it { expect(subject).to implement_show_action(self).for(resource) }

  # Update
  it {
    expect(subject).to implement_update_action(self)
      .for(resource)
      .within_form(".edit_establishment") {
        # fill the needed form inputs via capybara here
        #
        # Example:
        #
        #     fill_in 'slider[name]', with: 'New name'
        fill_in "establishment[name]", with: "New name"
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
