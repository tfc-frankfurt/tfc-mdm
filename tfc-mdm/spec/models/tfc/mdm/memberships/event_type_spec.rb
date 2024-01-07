require 'rails_helper'

module Tfc::Mdm
  RSpec.describe Memberships::EventType, type: :model do
    describe "associations" do
      it { expect(subject).to have_many(:events) }
    end

    describe "validations" do
      it { expect(subject).to validate_presence_of(:identifier) }
      it { expect(subject).to validate_uniqueness_of(:identifier) }
    end
  end
end
