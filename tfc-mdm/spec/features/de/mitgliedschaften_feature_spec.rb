require "rails_helper"

RSpec.describe "/de/vereine/mitgliedschaften/mitgliedschaften", type: :feature do
  let(:base_path) { "/de/vereine/mitgliedschaften/mitgliedschaften" }
  let(:current_user) { create(:user) }
  let(:person) { create(:tfc_mdm_person, user: current_user) }

  before(:each) do
    person
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(current_user)
  end

  # List
  describe "GET /de/vereine/mitgliedschaften/mitgliedschaften" do
    let(:memberships) { create_list(:tfc_mdm_memberships_membership, 3, person: current_user.person) }
    let(:index_path) { base_path }

    before(:each) { memberships }

    it "lists all memberships for the current user" do
      visit(index_path)

      expect(page).to have_text(memberships.first.club.human)
    end
  end

  # Show
  describe "GET /de/vereine/mitgliedschaften/mitgliedschaften/:id" do
    let(:membership) { create(:tfc_mdm_memberships_membership, person: current_user.person) }
    let(:show_path) { "#{base_path}/#{membership.to_param}" }

    it "renders the membership" do
      visit(show_path)

      expect(page).to have_text(membership.club.human)
    end
  end
end
