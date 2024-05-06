require 'rails_helper'

RSpec.describe Tfc::Mdm::Clubs::Club, type: :model do
  describe "associations" do
    it { expect(subject).to have_many(:bank_details) }
    it { expect(subject).to have_many(:email_addresses) }
    it { expect(subject).to have_many(:phone_numbers) }
    it { expect(subject).to have_many(:social_media) }
  end

  describe "validations" do
  end
end
