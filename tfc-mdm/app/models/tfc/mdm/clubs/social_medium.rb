module Tfc::Mdm
  class Clubs::SocialMedium < ApplicationRecord
    include Tfc::Mdm::Model::UuidConcern

    belongs_to :club, class_name: "Tfc::Mdm::Clubs::Club"

    validates :handle, presence: true, unless: -> { platform == "www" }
    validates :platform, presence: true, uniqueness: { scope: :club_id }
    validates :url, presence: true
  end
end
