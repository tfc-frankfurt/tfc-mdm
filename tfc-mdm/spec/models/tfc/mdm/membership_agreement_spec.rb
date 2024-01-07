require 'rails_helper'

module Tfc::Mdm
  RSpec.describe MembershipAgreement, type: :model do
    describe "associations" do
      it { expect(subject).to have_one(:membership_cancellation) }
    end
  end
end
