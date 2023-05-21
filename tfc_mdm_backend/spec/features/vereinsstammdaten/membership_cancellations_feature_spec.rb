# frozen_string_literal: true

require "rails_helper"

RSpec.describe "/de/backend/vereinsstammdaten/membership_cancellations", type: :feature do
  let(:resource_class) { Tfc::Mdm::MembershipCancellation }
  let(:resource) { create(:tfc_mdm_membership_cancellation) }
  let(:resources) { create_list(:tfc_mdm_membership_cancellation, 3) }
  let(:attributes) { attributes_for(:tfc_mdm_membership_cancellation) }

  let(:tfc_mdm_membership_agreement) { create(:tfc_mdm_membership_agreement) }

  # List
  it { resources; expect(subject).to implement_index_action(self) }

  # Create
  it {
    tfc_mdm_membership_agreement
    expect(subject).to implement_create_action(self)
      .for(resource_class)
      .within_form("#new_membership_cancellation") {
        # fill the needed form inputs via capybara here
        #
        # Example:
        #
        #     select 'de', from: 'slider[locale]'
        #     fill_in 'slider[name]', with: 'My first slider'
        #     check 'slider[auto_start]'
        #     fill_in 'slider[interval]', with: '3'
        select tfc_mdm_membership_agreement.human, from: "membership_cancellation[membership_agreement_id]"
        fill_in "membership_cancellation[entry_at]", with: attributes[:entry_at]
      }
      .increasing { Tfc::Mdm::MembershipCancellation.count }.by(1)
  }

  # Read
  it { expect(subject).to implement_show_action(self).for(resource) }

  # Update
  it {
    expect(subject).to implement_update_action(self)
      .for(resource)
      .within_form(".edit_membership_cancellation") {
        # fill the needed form inputs via capybara here
        #
        # Example:
        #
        #     fill_in 'slider[name]', with: 'New name'
        fill_in "membership_cancellation[entry_at]", with: Time.zone.now.beginning_of_year
      }
      .updating
      .from(resource.attributes)
      .to("entry_at" => Time.zone.now.beginning_of_year) # Example: .to({ 'name' => 'New name' })
  }

  # Delete
  it {
    expect(subject).to implement_delete_action(self)
      .for(resource)
      .reducing { resource_class.count }.by(1)
  }
end
