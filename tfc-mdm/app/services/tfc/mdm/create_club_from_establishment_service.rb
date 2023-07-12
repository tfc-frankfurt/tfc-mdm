# frozen_string_literal: true

module Tfc
  module Mdm
    class CreateClubFromEstablishmentService < Rao::Service::Base
      class Result < Rao::Service::Result::Base
        attr_accessor :club
      end

      attr_accessor :establishment_id

      validates :establishment_id, presence: true
      validates :establishment, presence: true

      private

        def _perform
          club = build_club
          addresses_role = build_addresses_role
          addresses_address = build_addresses_address(club, addresses_role, @establishment.happened_at)

          unless addresses_address.valid?
            add_error_and_say :address, "Could not create #{addresses_address.class.model_name.human}. Errors: #{addresses_address.errors.full_messages.to_sentence}"
            return
          end

          unless club.valid?
            add_error_and_say :club, "Could not create #{club.class.model_name.human}. Errors: #{club.errors.full_messages.to_sentence}"
            return
          end

          begin
            ActiveRecord::Base.transaction do
              club.save!
              addresses_address.save!
            end
          rescue ActiveRecord::RecordInvalid => e
            add_error_and_say :club, "Could not save club or address. Errors: #{e.message}"
            return
          end

          @result.club = club
        end

        def establishment
          @establishment ||= Establishment.find(@establishment_id)
        end

        def build_club
          Club.new.tap do |c|
            c.establishment = @establishment
            c.name = @establishment.name
            c
          end
        end

        def build_addresses_role
          Addresses::Role.where(identifier: "primary_address").first_or_initialize
        end

        def build_addresses_address(club, role, valid_from)
          Addresses::Address.new.tap do |a|
            a.record     = club
            a.role       = role
            a.valid_from = valid_from
            a.line1      = @establishment.name
            a.street     = @establishment.street
            a.zipcode    = @establishment.zipcode
            a.city       = @establishment.city
            a.country    = @establishment.country
            a
          end
        end
    end
  end
end
