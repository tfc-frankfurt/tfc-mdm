require 'rails_helper'

module Tfc::Mdm
  RSpec.describe Memberships::Event, type: :model do
    describe "associations" do
      it { expect(subject).to belong_to(:event_type) }
      it { expect(subject).to belong_to(:membership) }
    end

    describe "validations" do
      it { expect(subject).to validate_presence_of(:happened_at) }
    end
  end
end
