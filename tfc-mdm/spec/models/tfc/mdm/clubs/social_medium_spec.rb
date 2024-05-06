require 'rails_helper'

module Tfc::Mdm
  RSpec.describe Clubs::SocialMedium, type: :model do
    describe "associations" do
      it { expect(subject).to belong_to(:club) }
    end

    describe "validations" do
      subject { build(:tfc_mdm_clubs_social_medium) }

      it { expect(subject).to validate_presence_of(:handle) }
      it { expect(subject).to validate_presence_of(:platform) }
      it { expect(subject).to validate_uniqueness_of(:platform).scoped_to(:club_id) }
      it { expect(subject).to validate_presence_of(:url) }
    end
  end
end
