require "rails_helper"

RSpec.describe Tfc::Mdm::Memberships::BillingRunService, type: :service do
  describe "basic usage" do
    let(:tfc_mdm_club) { create(:tfc_mdm_club) }
    let(:memberships) { create_list(:tfc_mdm_memberships_membership, 3, club: tfc_mdm_club) }
    let(:attributes) { { club: tfc_mdm_club, memberships: memberships } }
    let(:options) { {} }
    
    subject { described_class.new(attributes, options) }

    describe "result" do
      subject { super().perform }
      
      it { expect(subject).to be_a(Rao::Service::Result::Base) }
      it { expect(subject).to be_ok }
      it { expect(subject.errors.full_messages).to match_array([]) }

      describe "invoices" do
        subject { super().invoices }

        it { expect(subject).to be_a(Array) }
        it { expect(subject.size).to eq(memberships.size) }
        it { expect(subject).to all(be_a(Bgit::Invoicing::Invoice)) }
        it { expect(subject.map(&:owner)).to all(be_a(Tfc::Mdm::Memberships::Membership)) }
      end
    end
  end
end
