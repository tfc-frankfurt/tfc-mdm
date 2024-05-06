require "rails_helper"

RSpec.describe "/de/vereine/vereine", type: :feature do
  let(:base_path) { "/de/vereine/vereine" }

  # List
  describe "GET /de/vereine/vereine" do
    let(:index_path) { base_path }
    let(:club) { create(:tfc_mdm_clubs_club) }

    before(:each) { club }

    it "lists all clubs" do
      visit(index_path)

      expect(page).to have_text(club.name)
    end
  end

  # Show
  describe "GET /de/vereine/vereine/:id" do
    let(:show_path) { "#{base_path}/#{club.to_param}" }
    let(:club) { create(:tfc_mdm_clubs_club) }

    before(:each) { club }

    it "renders the club" do
      visit(show_path)

      expect(page).to have_text(club.name)
    end
  end
end
