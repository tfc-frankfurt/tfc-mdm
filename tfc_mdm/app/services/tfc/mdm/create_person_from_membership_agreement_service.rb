# frozen_string_literal: true

module Tfc::Mdm
  class CreatePersonFromMembershipAgreementService < Rao::Service::Base
    class Result < Rao::Service::Result::Base
      attr_accessor :person
    end

    attr_accessor :membership_agreement_id
    attr_accessor :membership_agreement

    validates :membership_agreement, presence: true

    private

      def _perform
        person = build_person
        addresses_role = build_addresses_role
        addresses_address = build_addresses_address(person, addresses_role, @membership_agreement.entry_at)

        unless addresses_address.valid?
          add_error_and_say :address, "Could not create #{addresses_address.class.model_name.human}. Errors: #{addresses_address.errors.full_messages.to_sentence}"
          return
        end

        unless person.valid?
          add_error_and_say :person, "Could not create #{person.class.model_name.human}. Errors: #{person.errors.full_messages.to_sentence}"
          return
        end

        begin
          ActiveRecord::Base.transaction do
            person.save!
            addresses_address.save!
            @membership_agreement.update_attribute(:person_id, person.id)
          end
        rescue ActiveRecord::RecordInvalid => e
          add_error_and_say :person, "Could not save person or address. Errors: #{e.message}"
          return
        end

        @result.person = person
      end

      def self.human
        I18n.t("classes.#{name.tableize.singularize}")
      end

    private

      def build_person
        Person.new.tap do |p|
          p.salutation = @membership_agreement.salutation
          p.firstname  = @membership_agreement.firstname
          p.lastname   = @membership_agreement.lastname
          p.birthdate  = @membership_agreement.birthdate
          p
        end
      end

      def build_addresses_role
        Addresses::Role.where(identifier: "primary_address").first_or_initialize
      end

      def build_addresses_address(person, role, valid_from)
        Addresses::Address.new.tap do |a|
          a.record     = person
          a.role       = role
          a.valid_from = valid_from
          a.line1      = @membership_agreement.fullname
          a.street     = @membership_agreement.street
          a.zipcode    = @membership_agreement.zipcode
          a.city       = @membership_agreement.city
          a.country    = @membership_agreement.country
          a
        end
      end

      def membership_agreement
        @membership_agreement ||= MembershipAgreement.find(@membership_agreement_id)
      end
  end
end
