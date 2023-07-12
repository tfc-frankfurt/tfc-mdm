require "rails_helper"

RSpec.describe "/de/backend/vereinsstammdaten/create_club_from_establishment_service", type: :feature do
  let(:base_path) { "/de/backend/vereinsstammdaten/create_club_from_establishment_service" }
  let(:new_path) { "#{base_path}/new" }

  let(:establishment) { create(:tfc_mdm_establishment) }

  let(:success_message) { "Dienst zur Erstellung von Vereinen aus Gründungen wurde ausgeführt." }

  # Perform
  it do
    establishment
    
    visit(new_path)
    expect(page).to have_http_status(:ok)
    expect(page).to have_current_path(new_path)
  
    select establishment.human, from: "create_club_from_establishment_service[establishment_id]"

    expect { click_button "Ausführen" }.to change(Tfc::Mdm::Club, :count).by(1)

    expect(page).to have_http_status(:ok)
    expect(page).to have_current_path(base_path)

    expect(page.body).to have_content(success_message)
  end
end
