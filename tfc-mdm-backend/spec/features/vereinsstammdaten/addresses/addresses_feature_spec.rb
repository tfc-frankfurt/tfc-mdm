require "rails_helper"

RSpec.describe "/de/backend/vereinsstammdaten/addresses/addresses", type: :feature do
  let(:resource_class) { Tfc::Mdm::Addresses::Address }
  let(:resource) { create(:tfc_mdm_addresses_address) }
  let(:resources) { create_list(:tfc_mdm_addresses_address, 3) }

  let(:club) { create(:tfc_mdm_club) }
  let(:role) { create(:tfc_mdm_addresses_role) }

  # List
  it { resources; expect(subject).to implement_index_action(self) }

  # Create
  describe "Create", type: :system do
    it do
      club
      role
      expect(subject).to implement_create_action(self)
        .for(resource_class)
        .within_form("body") {
          select(club.class.model_name.human, from: "addresses_address[record_type]")
          
          first('.select2-container', minimum: 1).click
          find('.select2-search--dropdown input.select2-search__field').send_keys(club.human)
          sleep(1)
          find('.select2-search--dropdown input.select2-search__field').send_keys(:enter)

          select role.human, from: "addresses_address[role_id]"
          fill_in "addresses_address[line1]", with: "Line 1"
          fill_in "addresses_address[street]", with: "Hauptstraße 1"
          fill_in "addresses_address[zipcode]", with: "12345"
          fill_in "addresses_address[city]", with: "Musterstadt"
          select "Deutschland", from: "addresses_address[country]"
          fill_in "addresses_address[valid_from]", with: "1970-01-01"
          fill_in "addresses_address[valid_to]", with: "2099-12-31"
        }.increasing { resource_class.count }.by(1)
    end
  end

  # Read
  it { expect(subject).to implement_show_action(self).for(resource) }

  # Update
  it do
    expect(subject).to implement_update_action(self)
      .for(resource)
      .within_form(".edit_addresses_address") {
        fill_in "addresses_address[street]", with: "Hauptstraße 2"
      }.updating
      .from(resource.attributes)
      .to({ "street" => "Hauptstraße 2" })
  end

  # Delete
  it do
    expect(subject).to implement_delete_action(self)
      .for(resource)
      .reducing { resource_class.count }.by(1)
  end
end
