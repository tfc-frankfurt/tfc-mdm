module Tfc::Mdm
  class Clubs::PhoneNumber < ApplicationRecord
    include Tfc::Mdm::Model::UuidConcern

    belongs_to :club, class_name: "Tfc::Mdm::Clubs::Club"

    validates :number, presence: true
    validates :role, presence: true, uniqueness: { scope: :club_id }
  end
end
