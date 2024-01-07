require 'rails_helper'

module Tfc::Mdm
  RSpec.describe Memberships::Category, type: :model do
    describe "associations" do
      it { expect(subject).to belong_to(:club) }
      it { expect(subject).to have_many(:fees) }
      it { expect(subject).to have_one(:current_fee) }
    end

    describe "validations" do
      subject { create(:tfc_mdm_memberships_category) }
      
      it { expect(subject).to validate_presence_of(:identifier) }
      it { expect(subject).to validate_uniqueness_of(:identifier).scoped_to(:club_id) }
    end
  end
end
