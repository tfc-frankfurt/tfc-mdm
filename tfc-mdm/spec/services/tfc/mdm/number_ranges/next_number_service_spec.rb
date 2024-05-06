require "rails_helper"

RSpec.describe Tfc::Mdm::NumberRanges::NextNumberService, type: :service do
  include ActiveSupport::Testing::TimeHelpers

  describe "basic usage" do
    let(:attributes) { {identifier: "membership_number"} }
    let(:options) { {} }

    subject { described_class.new(attributes, options) }

    before { Tfc::Mdm::NumberRanges::SeedService.call! }

    around(:each) do |example|
      travel_to(Time.zone.local(2023, 7, 1, 12, 0, 0)) { example.run }
    end

    describe "result" do
      subject { super().perform }

      it { expect(subject).to be_a(Rao::Service::Result::Base) }
      it { expect(subject).to be_ok }
      it { expect(subject.errors.full_messages).to match_array([]) }

      describe "value" do
        it { expect(subject.value).to eq("MG-00001") }
      end
    end
  end

  describe "consecutive calls" do
    before(:each) { Tfc::Mdm::NumberRanges::SeedService.call! }

    it "returns the next value" do
      expect(described_class.call!(identifier: "membership_number").value).to eq("MG-00001")
      expect(described_class.call!(identifier: "membership_number").value).to eq("MG-00002")
      expect(described_class.call!(identifier: "membership_number").value).to eq("MG-00003")
    end
  end
end
