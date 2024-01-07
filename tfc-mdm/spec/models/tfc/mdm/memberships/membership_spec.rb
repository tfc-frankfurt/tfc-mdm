require 'rails_helper'

module Tfc::Mdm
  RSpec.describe Memberships::Membership, type: :model do
    describe "associations" do
      it { expect(subject).to belong_to(:club) }
      it { expect(subject).to belong_to(:person) }
      it { expect(subject).to belong_to(:category) }
    end

    describe "validations" do
      it { expect(subject).to validate_presence_of(:active_from) }
      it { expect(subject).to validate_presence_of(:active_to) }
    end
  end
end
