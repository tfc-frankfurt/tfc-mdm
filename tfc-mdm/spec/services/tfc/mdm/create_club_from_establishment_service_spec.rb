require "rails_helper"

RSpec.describe Tfc::Mdm::CreateClubFromEstablishmentService, type: :service do
  describe "basic usage" do
    let(:establishment) do
      create(:tfc_mdm_establishment).tap do |e|
        e.logo.attach(
          io: File.open(Tfc::Mdm::Engine.root.join(*%w(spec files tfc mdm establishment logo example.jpg))),
          filename: "example.jpg",
          content_type: "image/jpeg"
        )
      end
    end
    let(:attributes) { { establishment_id: establishment.id } }
    let(:options) { {} }
    
    subject { described_class.new(attributes, options) }

    describe "result" do
      it { expect(subject.perform).to be_a(Rao::Service::Result::Base) }
      it { expect(subject.perform.errors.full_messages).to match_array([]) }
    end

    describe "persistence changes" do
      before(:each) { subject }
      it { expect { subject.perform }.to change { Tfc::Mdm::Club.count }.by(1) }
      it { expect { subject.perform }.to change { Tfc::Mdm::Addresses::Address.count }.by(1) }
      it { expect { subject.perform }.to change { Tfc::Mdm::Addresses::Role.count }.by(1) }
      it { expect { subject.perform }.to change { ActiveStorage::Attachment.count }.by(1) }
      it { expect { subject.perform }.to change { ActiveStorage::Blob.count }.by(1) }
    end
  end
end
