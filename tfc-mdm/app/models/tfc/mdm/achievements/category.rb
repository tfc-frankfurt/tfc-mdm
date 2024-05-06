module Tfc::Mdm
  class Achievements::Category < ApplicationRecord
    belongs_to :club, class_name: "Tfc::Mdm::Clubs::Club"
    has_many :achievements

    validates :name_de, presence: true, uniqueness: { scope: [ :club_id ] }
    validates :name_en, presence: true, uniqueness: { scope: [ :club_id ] }

    def name(locale = nil)
      send("name_#{(locale || I18n.locale)}")
    end
  end
end
