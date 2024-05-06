require 'rails_helper'

RSpec.describe Tfc::Mdm::Addresses::Address, type: :model do
  describe "associations" do
    it { expect(subject).to belong_to(:record) }
    it { expect(subject).to belong_to(:role) }
  end

  describe "validations" do
  end
end
