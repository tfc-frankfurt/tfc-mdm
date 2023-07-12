module Tfc::Mdm
  class Positions::Position < ApplicationRecord
    belongs_to :club
    has_many :entries

    validates :name_de, presence: true, uniqueness: { scope: [ :club_id ] }
    validates :name_en, presence: true, uniqueness: { scope: [ :club_id ] }

    # scope :occupied, -> { joins(:entries).merge(Tfc::Mdm::Positions::Entry.actual).distinct }
    scope :occupied, -> { joins(:entries).merge(Tfc::Mdm::Positions::Entry.actual) }

    def human
      name
    end

    def name
      send("name_#{I18n.locale}")
    end
  end
end
