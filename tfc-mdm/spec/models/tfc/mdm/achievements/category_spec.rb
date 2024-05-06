require 'rails_helper'

RSpec.describe Tfc::Mdm::Achievements::Category, type: :model do
  describe "associations" do
    it { expect(subject).to belong_to(:club) }
    it { expect(subject).to have_many(:achievements) }
  end

  describe "validations" do
  end
end
