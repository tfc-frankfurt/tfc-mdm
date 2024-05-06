module Tfc::Mdm
  class Clubs::BankDetail < ApplicationRecord
    include Tfc::Mdm::Model::UuidConcern

    belongs_to :club, class_name: "Tfc::Mdm::Clubs::Club"

    validates :account_holder, presence: true
    validates :bank_name, presence: true
    validates :bic, presence: true
    validates :iban, presence: true
    validates :role, presence: true, uniqueness: { scope: :club_id }
  end
end
