require 'rails_helper'

module Tfc::Mdm
  RSpec.describe Memberships::Fee, type: :model do
    describe "associations" do
      it { expect(subject).to belong_to(:category) }
    end

    describe "validations" do
      subject { create(:tfc_mdm_memberships_fee) }

      it { expect(subject).to validate_numericality_of(:amount).is_greater_than_or_equal_to(0) }
    end
  end
end
