require 'rails_helper'

RSpec.describe Tfc::Mdm::Achievements::Achievement, type: :model do
  describe "associations" do
    it { expect(subject).to belong_to(:club) }
    it { expect(subject).to belong_to(:category) }
    it { expect(subject).to belong_to(:achiever) }
  end

  describe "validations" do
  end
end
