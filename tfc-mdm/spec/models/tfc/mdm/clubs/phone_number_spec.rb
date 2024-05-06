require 'rails_helper'

module Tfc::Mdm
  RSpec.describe Clubs::PhoneNumber, type: :model do
    describe "associations" do
      it { expect(subject).to belong_to(:club) }
    end

    describe "validations" do
      subject { build(:tfc_mdm_clubs_phone_number) }

      it { expect(subject).to validate_presence_of(:number) }
      it { expect(subject).to validate_presence_of(:role) }
      it { expect(subject).to validate_uniqueness_of(:role).scoped_to(:club_id) }
    end
  end
end
