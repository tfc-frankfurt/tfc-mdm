require "rails_helper"

RSpec.describe "/de/backend/vereinsstammdaten/memberships/fees", type: :feature do
  let(:resource_class) { Tfc::Mdm::Memberships::Fee }
  let(:resource) { create(:tfc_mdm_memberships_fee) }
  let(:resources) { create_list(:tfc_mdm_memberships_fee, 3) }

  let(:category) { create(:tfc_mdm_memberships_category) }

  # List
  it { resources; expect(subject).to implement_index_action(self) }

  # Create
  it do
    category
    expect(subject).to implement_create_action(self)
      .for(resource_class)
      .within_form("#new_memberships_fee") {
        select category.human, from: "memberships_fee[category_id]"
        
        fill_in "memberships_fee[amount]", with: "5,00"
        fill_in "memberships_fee[active_from]", with: 1.year.ago.strftime("%d.%m.%Y %H:%M:%S")
        fill_in "memberships_fee[active_to]", with: 1.year.from_now.strftime("%d.%m.%Y %H:%M:%S")
      }.increasing { resource_class.count }.by(1)
  end

  # Read
  it { expect(subject).to implement_show_action(self).for(resource) }

  # Update
  it do
    expect(subject).to implement_update_action(self)
      .for(resource)
      .within_form(".edit_memberships_fee") {
        fill_in "memberships_fee[amount]", with: "7,50"
      }.updating
      .from(resource.attributes)
      .to({ "amount_cents" => 750 })
  end

  # Delete
  it do
    expect(subject).to implement_delete_action(self)
      .for(resource)
      .reducing { resource_class.count }.by(1)
  end
end
