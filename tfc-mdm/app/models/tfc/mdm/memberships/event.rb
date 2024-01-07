module Tfc::Mdm
  class Memberships::Event < ApplicationRecord
    belongs_to :event_type
    belongs_to :membership, touch: true
    has_one :person, through: :membership

    validates :happened_at, presence: true
    validates :event_type, uniqueness: { scope: :membership_id }, if: -> { %w(agreement termination).include?(event_type&.identifier) }

    scope :agreements, -> { joins(:event_type).where(tfc_mdm_memberships_event_types: { identifier: "agreement" }) }
    scope :terminations, -> { joins(:event_type).where(tfc_mdm_memberships_event_types: { identifier: "termination" }) }

    scope :in_year, ->(year) { where(happened_at: year.beginning_of_year..year.end_of_year) }
    scope :for_year, ->(year) { where(effective_at: year.beginning_of_year..year.end_of_year) }

    delegate :color, to: :event_type, allow_nil: true, prefix: true

    def human
      [event_type.class.human_value_name(:identifier, event_type.identifier, count: :one)].join(" ")
    end

    def to_timeline_event
      Timeline::Event.new(title: event_type.human_value_name(:identifier), description: person.human, happened_at: effective_at, color: event_type_color)
    end

    module EffectiveConcern
      extend ActiveSupport::Concern

      included do
        before_validation :calculate_effective_at, if: -> { effective_at.nil? }
      end

      private

      def calculate_effective_at
        case event_type&.identifier
        when "agreement"
          self.effective_at = happened_at
        when "termination"
          self.effective_at = happened_at.end_of_year
        end
      end
    end

    include EffectiveConcern
  end
end
