module Tfc::Mdm
  class Clubs::EmailAddress < ApplicationRecord
    include Tfc::Mdm::Model::UuidConcern

    belongs_to :club, class_name: "Tfc::Mdm::Clubs::Club"

    validates :email, presence: true
    validates :role, presence: true, uniqueness: { scope: :club_id }
  end
end
