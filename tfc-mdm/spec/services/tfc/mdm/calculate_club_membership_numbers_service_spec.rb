require "rails_helper"

RSpec.describe Tfc::Mdm::CalculateClubMembershipNumbersService, type: :service do
  describe "basic usage" do
    let(:establishment) { create(:tfc_mdm_establishment, happened_at: 15.years.ago) }
    let(:club) { create(:tfc_mdm_clubs_club, establishment: establishment) }
    let(:attributes) { { club: club } }
    let(:options) { {} }
    
    subject { described_class.new(attributes, options) }

    describe "result" do
      subject { super().perform }

      it { expect(subject).to be_a(Rao::Service::Result::Base) }
      it { expect(subject).to be_ok }
      it { expect(subject.errors.full_messages).to eq([]) }

      describe "membership_numbers" do
        subject { super().membership_numbers }

        it { expect(subject).to be_a(Array) }
        it { expect(subject.size).to eq(16) }

        describe "year" do
          subject { super().first.year }

          it { expect(subject).to eq(15.years.ago.beginning_of_year) }
        end

        describe "agreements" do
          let(:membership) { create(:tfc_mdm_memberships_membership, club: club) }
          let(:event_type) { create(:tfc_mdm_memberships_event_type, identifier: "agreement") }
          let(:agreement) { create(:tfc_mdm_memberships_event, event_type: event_type, membership: membership, happened_at: 15.years.ago) }
          
          subject { super().first.agreements }

          before(:each) { agreement }

          it { expect(subject.size).to eq(1) }
        end

        describe "terminations" do
          let(:membership) { create(:tfc_mdm_memberships_membership, club: club) }
          let(:event_type) { create(:tfc_mdm_memberships_event_type, identifier: "termination") }
          let(:termination) { create(:tfc_mdm_memberships_event, event_type: event_type, membership: membership, happened_at: 15.years.ago) }
          
          subject { super().first.terminations }

          before(:each) { termination }

          it { expect(subject.size).to eq(1) }
        end

        describe "active_members_at_start_of_year" do
          subject { super().first.active_members_at_start_of_year }
        end

        describe "active_members_at_end_of_year" do
          subject { super().first.active_members_at_end_of_year }

          describe "when there is one agreement and no termination" do
            let(:membership) { create(:tfc_mdm_memberships_membership, club: club) }
            let(:event_type) { create(:tfc_mdm_memberships_event_type, identifier: "agreement") }
            let(:agreement) { create(:tfc_mdm_memberships_event, event_type: event_type, membership: membership, happened_at: 15.years.ago) }
            
            before(:each) { agreement }

            it { expect(subject.size).to eq(1) }
          end

          describe "when there is one agreement and one termination" do
            let(:membership) { create(:tfc_mdm_memberships_membership, club: club) }
            let(:event_type_agreement) { create(:tfc_mdm_memberships_event_type, identifier: "agreement") }
            let(:event_type_termination) { create(:tfc_mdm_memberships_event_type, identifier: "termination") }
            let(:agreement) { create(:tfc_mdm_memberships_event, event_type: event_type_agreement, membership: membership, happened_at: 15.years.ago) }
            let(:termination) { create(:tfc_mdm_memberships_event, event_type: event_type_termination, membership: membership, happened_at: 15.years.ago, effective_at: 15.years.ago.end_of_year) }
            
            before(:each) { agreement; termination }

            it { expect(subject.size).to eq(0) }
          end
        end

        describe "membership_development" do
        end
      end
      
      describe "years" do
        subject { super().years }

        it { expect(subject).to be_a(Array) }
        it { expect(subject.size).to eq(16) }
      end
    end
  end
end
