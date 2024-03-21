module Tfc
  module Mdm
    module Model
      module ActiveConcern
        extend ActiveSupport::Concern

        included do
          validates :active_from, presence: true
          validates :active_to, presence: true

          scope :active, -> { active_at(Time.zone.now) }
          scope :active_at, ->(point_in_time) {
            t = arel_table
            where(t[:active_from].lteq(point_in_time)).where(t[:active_to].gteq(point_in_time))
          }
          scope :active_in, ->(range) {
            t = arel_table
            where(t[:active_from].lteq(range.end)).where(t[:active_to].gteq(range.begin))
          }

          after_initialize do
            self.active_from ||= Time.at(0)
            self.active_to ||= Time.new(9999, 12, 31, 23, 59, 59)
          end
        end

        def active_at(point_in_time)
          active_from < point_in_time && active_to > point_in_time
        end

        def active?
          active_at(Time.zone.now)
        end

        alias :active :active?
      end
    end
  end
end
