require "rails_helper"

RSpec.describe "/de/backend/vereinsstammdaten/notify_about_new_membership_agreement_service", type: :feature do
  let(:base_path) { "/de/backend/vereinsstammdaten/notify_about_new_membership_agreement_service" }
  let(:new_path) { "#{base_path}/new" }

  let(:membership_agreement) { create(:tfc_mdm_membership_agreement) }

  let(:success_message) { "Dienst zur Benachrichtigung über neue Beitritte wurde ausgeführt." }

  # Perform
  it do
    membership_agreement
    
    visit(new_path)
    expect(page).to have_http_status(:ok)
    expect(page).to have_current_path(new_path)

    select "#{membership_agreement.fullname} - #{I18n.l(membership_agreement.entry_at)}", from: "notify_about_new_membership_agreement_service[membership_agreement_id]"
  
    expect { click_button "Ausführen" }.to have_enqueued_job(ActionMailer::MailDeliveryJob)

    expect(page).to have_http_status(:ok)
    expect(page).to have_current_path(base_path)

    expect(page.body).to have_content(success_message)
  end
end
