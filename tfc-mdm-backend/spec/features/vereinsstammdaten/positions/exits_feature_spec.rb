require 'rails_helper'

RSpec.describe "/de/backend/vereinsstammdaten/positions/exits", type: :feature do
  let(:resource_class) { Tfc::Mdm::Positions::Exit }
  let(:resource) { create(:tfc_mdm_positions_exit) }
  let(:resources) { create_list(:tfc_mdm_positions_exit, 3) }

  # List
  it { resources; expect(subject).to implement_index_action(self) }

  # Read
  it { expect(subject).to implement_show_action(self).for(resource) }

  # Update
  it do
    expect(subject).to implement_update_action(self)
      .for(resource)
      .within_form(".edit_positions_exit") {
        # fill the needed form inputs via capybara here
        #
        # Example:
        #
        #     fill_in 'slider[name]', with: 'New name'
        fill_in "positions_exit[happened_at]", with: 1.day.ago.strftime("%d.%m.%Y")
      }.updating
      .from(resource.attributes)
      .to("happened_at" => 1.day.ago.to_date) # Example: .to({ 'name' => 'New name' })
  end

  # Delete
  it do
    expect(subject).to implement_delete_action(self)
      .for(resource)
      .reducing { resource_class.count }.by(1)
  end
end
