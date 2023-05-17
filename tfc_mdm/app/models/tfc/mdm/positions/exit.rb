module Tfc::Mdm
  class Positions::Exit < ApplicationRecord
    belongs_to :club
    belongs_to :entry

    validates :happened_at, presence: true
    validates :entry_id, uniqueness: true

    def human
      "#{entry.position.name} - #{entry.positionable.human} (#{entry.happened_at} - #{happened_at})"
    end
  end
end
