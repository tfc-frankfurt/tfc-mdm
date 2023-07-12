module Tfc::Mdm
  class Positions::Entry < ApplicationRecord
    belongs_to :club
    belongs_to :position
    belongs_to :positionable, polymorphic: true
    has_one :exit

    has_one_attached :image

    validates :email, presence: true

    scope :active, ->{ left_outer_joins(:exit).where('tfc_mdm_positions_exits.entry_id IS NULL') }
    scope :for_position_by_name_en, ->(position_name_en) { includes(:position).where('tfc_mdm_positions_positions': { name_en: position_name_en }) }

    def self.actual
      active.order(happened_at: :desc)
    end

    def self.acting(position)
      where(position_id: position.id).actual.first
    end

    def self.acting_by_position_name_en(position_name_en)
      for_position_by_name_en(position_name_en).actual.first
    end

    def human
      "#{position.name} - #{positionable.human} (#{happened_at})"
    end
  end
end
