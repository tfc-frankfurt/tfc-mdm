require 'rails_helper'

RSpec.describe Tfc::Mdm::Addresses::Role, type: :model do
  describe "associations" do
    it { expect(subject).to belong_to(:club) }
    it { expect(subject).to have_many(:addresses) }
  end

  describe "validations" do
    subject { build(:tfc_mdm_addresses_role) }
    
    it { expect(subject).to validate_presence_of(:identifier) }
    it { expect(subject).to validate_uniqueness_of(:identifier).scoped_to(:club_id) }
  end
end
