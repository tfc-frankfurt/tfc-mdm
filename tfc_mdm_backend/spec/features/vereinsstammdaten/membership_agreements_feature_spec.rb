# frozen_string_literal: true

require "rails_helper"

RSpec.describe "/de/backend/vereinsstammdaten/membership_agreements", type: :feature do
  let(:resource_class) { Tfc::Mdm::MembershipAgreement }
  let(:resource) { create(:tfc_mdm_membership_agreement) }
  let(:resources) { create_list(:tfc_mdm_membership_agreement, 3) }
  let(:attributes) { attributes_for(:tfc_mdm_membership_agreement) }

  let(:tfc_mdm_club) { create(:tfc_mdm_club) }

  # List
  it { resources; expect(subject).to implement_index_action(self) }

  # Create
  it {
    tfc_mdm_club
    expect(subject).to implement_create_action(self)
      .for(resource_class)
      .within_form("#new_membership_agreement") {
        # fill the needed form inputs via capybara here
        #
        # Example:
        #
        #     select 'de', from: 'slider[locale]'
        #     fill_in 'slider[name]', with: 'My first slider'
        #     check 'slider[auto_start]'
        #     fill_in 'slider[interval]', with: '3'
        select tfc_mdm_club.name, from: "membership_agreement[club_id]"
        fill_in "membership_agreement[salutation]", with: attributes[:salutation]
        fill_in "membership_agreement[firstname]", with: attributes[:firstname]
        fill_in "membership_agreement[lastname]", with: attributes[:lastname]
        fill_in "membership_agreement[street]", with: attributes[:street]
        fill_in "membership_agreement[zipcode]", with: attributes[:zipcode]
        fill_in "membership_agreement[city]", with: attributes[:city]
        select "Deutschland", from: "membership_agreement[country]"
        fill_in "membership_agreement[birthdate]", with: attributes[:birthdate]
        fill_in "membership_agreement[phone]", with: attributes[:phone]
        fill_in "membership_agreement[email]", with: attributes[:email]
        fill_in "membership_agreement[entry_at]", with: attributes[:entry_at]
      }
      .increasing { Tfc::Mdm::MembershipAgreement.count }.by(1)
  }

  # Read
  it { expect(subject).to implement_show_action(self).for(resource) }

  # Update
  it {
    expect(subject).to implement_update_action(self)
      .for(resource)
      .within_form(".edit_membership_agreement") {
        # fill the needed form inputs via capybara here
        #
        # Example:
        #
        #     fill_in 'slider[name]', with: 'New name'
        fill_in "membership_agreement[email]", with: "a-new-email@domain.local"
      }
      .updating
      .from(resource.attributes)
      .to("email" => "a-new-email@domain.local") # Example: .to({ 'name' => 'New name' })
  }

  # Delete
  it {
    expect(subject).to implement_delete_action(self)
      .for(resource)
      .reducing { resource_class.count }.by(1)
  }
end
