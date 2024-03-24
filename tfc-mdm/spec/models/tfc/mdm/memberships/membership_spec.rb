require 'rails_helper'

module Tfc::Mdm
  RSpec.describe Memberships::Membership, type: :model do
    describe "associations" do
      it { expect(subject).to belong_to(:club) }
      it { expect(subject).to belong_to(:person) }
      it { expect(subject).to belong_to(:category) }
      it { expect(subject).to have_many(:billed_items) }
      it { expect(subject).to have_many(:line_items) }
      it { expect(subject).to have_many(:invoices) }
    end

    describe "validations" do
      it { expect(subject).to validate_presence_of(:active_from) }
      it { expect(subject).to validate_presence_of(:active_to) }
    end
  end
end
