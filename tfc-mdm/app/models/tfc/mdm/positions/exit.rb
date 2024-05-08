module Tfc::Mdm
  class Positions::Exit < ApplicationRecord
    belongs_to :club, class_name: "Tfc::Mdm::Clubs::Club"
    belongs_to :entry
    has_one :position, through: :entry

    validates :happened_at, presence: true
    validates :entry_id, uniqueness: true

    def human
      "#{entry.position.name} - #{entry.positionable.human} (#{entry.happened_at} - #{happened_at})"
    end

    def positionable
      entry.positionable
    end
  end
end
