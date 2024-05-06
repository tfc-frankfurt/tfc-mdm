module Tfc
  module Mdm
    module NumberRanges
      class SeedService < Rao::Service::Base
        class Result < Rao::Service::Result::Base
          attr_accessor :number_ranges
        end

        private

        def _perform
          @result.number_ranges = build_number_ranges!
        end

        def build_number_ranges!
          default_number_ranges.collect do |attrs|
            say "Building number range for #{attrs[:identifier]}" do
              Tfc::Mdm::NumberRange.where(identifier: attrs[:identifier]).first_or_initialize do |nr|
                nr.attributes = attrs
              end
            end
          end
        end

        def default_number_ranges
          [
            {identifier: "membership_number", prefix: "MG", format: "-", next_value: 1, minimum_length: 5},
          ]
        end

        def save
          ActiveRecord::Base.transaction do
            @result.number_ranges.map(&:save!)
          end
        end
      end
    end
  end
end
