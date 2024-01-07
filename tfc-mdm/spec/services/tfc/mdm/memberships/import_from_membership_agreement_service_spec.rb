require "rails_helper"

RSpec.describe Tfc::Mdm::Memberships::ImportFromMembershipAgreementService, type: :service do
  describe "basic usage" do
    let(:tfc_mdm_club) { create(:tfc_mdm_club) }
    let(:tfc_mdm_memberships_category) { create(:tfc_mdm_memberships_category, club: tfc_mdm_club, identifier: "active") }
    let(:membership_agreement) { create(:tfc_mdm_membership_agreement, club: tfc_mdm_club) }
    let(:membership_cancellation) { create(:tfc_mdm_membership_cancellation, membership_agreement: membership_agreement) }
    let(:attributes) { {membership_agreement: membership_agreement } }
    let(:options) { {} }

    subject { described_class.new(attributes, options) }

    before(:each) do
      tfc_mdm_memberships_category
      membership_cancellation
    end

    describe "result" do
      subject { super().perform }
      
      it { expect(subject).to be_a(Rao::Service::Result::Base) }
      it { expect(subject).to be_ok }
      it { expect(subject.errors.full_messages).to match_array([]) }
    end

    describe "persistence changes" do
      let(:options) { {autosave: true} }
      
      it { expect { subject.perform }.to change { Tfc::Mdm::Memberships::Membership.count }.by(1) }
      it { expect { subject.perform }.to change { Tfc::Mdm::Memberships::Event.agreements.count }.from(0).to(1) }
      it { expect { subject.perform }.to change { Tfc::Mdm::Memberships::Event.terminations.count }.from(0).to(1) }
      it { expect { subject.perform }.to change { Tfc::Mdm::Memberships::EventType.pluck(:identifier) }.from([]).to(["agreement", "termination"]) }
      it { expect { subject.perform }.to change { User.count }.by(1) }
    end
  end
end
