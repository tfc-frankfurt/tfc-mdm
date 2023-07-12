# frozen_string_literal: true

module Tfc
  module Mdm
    class Addresses::Address < ApplicationRecord
      belongs_to :record, polymorphic: true
      belongs_to :role, inverse_of: :addresses

      validates :line1, :street, :zipcode, :city, :country, presence: true

      module GeocodingConcern
        extend ActiveSupport::Concern
        included do
          geocoded_by :geocoding_address
          after_validation :geocode
        end

        private

          def geocoding_address
            [street, city, country].compact.join(", ")
          end
      end

      include GeocodingConcern

      def oneline
        [line1, line2, street, "#{zipcode} #{city}", country].reject { |i| i.nil? || i.blank? }.join(", ")
      end

      def human
        "#{oneline} (#{role.identifier})"
      end

      module ValidityConcern
        extend ActiveSupport::Concern
        included do
          validates :valid_from, presence: true
          validates :valid_to,   presence: true
          after_initialize :set_validity_defaults, if: :new_record?
        end

        private

          def set_validity_defaults
            self.valid_from = "01.01.1900 00:00:00"
            self.valid_to   = "31.12.9999 23:59:59"
          end
      end

      include ValidityConcern
    end
  end
end
