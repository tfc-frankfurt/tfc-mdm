require "rails_helper"

RSpec.describe "/de/backend/vereinsstammdaten/achievements/achievements", type: :system do
  let(:resource_class) { Tfc::Mdm::Achievements::Achievement }
  let(:resource) { create(:tfc_mdm_achievements_achievement) }
  let(:resources) { create_list(:tfc_mdm_achievements_achievement, 3) }

  let(:category) { create(:tfc_mdm_achievements_category) }
  let(:achiever) { create(:tfc_mdm_person) }
  let(:club) { create(:tfc_mdm_club) }

  # List
  it { resources; expect(subject).to implement_index_action(self) }

  # Create
  it do
    achiever
    category
    club
    expect(subject).to implement_create_action(self)
      .for(resource_class)
      .within_form("body") {
        select(club.name, from: "achievements_achievement[club_id]")
        select(category.name, from: "achievements_achievement[category_id]")
        select(achiever.class.model_name.human, from: "achievements_achievement[achiever_type]")

        first('.select2-container', minimum: 1).click
        find('.select2-search--dropdown input.select2-search__field').send_keys("Jan")
        sleep(1)
        find('.select2-search--dropdown input.select2-search__field').send_keys(:enter)

        fill_in("achievements_achievement[happened_at]", with: "01/01/2018")
      }.increasing { resource_class.count }.by(1)
  end

  # Read
  it { expect(subject).to implement_show_action(self).for(resource) }
end
