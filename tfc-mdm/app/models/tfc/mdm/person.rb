# frozen_string_literal: true

module Tfc
  module Mdm
    class Person < ActiveRecord::Base
      include SimpleFormPolymorphicAssociations::Model::AutocompleteConcern

      belongs_to :user, class_name: Tfc::Mdm::Configuration.user_class_name, optional: true, inverse_of: :person
      has_many :membership_agreements
      has_many :membership_cancellations
      has_many :memberships, dependent: :restrict_with_error, class_name: "Tfc::Mdm::Memberships::Membership", inverse_of: :person
      has_many :memberships_events, through: :memberships, class_name: "Tfc::Mdm::Memberships::Event", source: :events
      has_many :clubs, through: :memberships

      validates :salutation, presence: true
      validates :firstname, presence: true
      validates :lastname, presence: true
      validates :birthdate, presence: true

      # autocomplete scope: ->(matcher) { where("lower(tfc_mdm_people.firstname) LIKE :term", term: "%#{matcher.downcase}%") }, id_method: :id, text_method: :human
      autocomplete scope: ->(matcher) { where("lower(TRIM(tfc_mdm_people.firstname || ' ' || tfc_mdm_people.lastname)) LIKE :term", term: "%#{matcher.downcase}%") }, id_method: :id, text_method: :human

      def events
        [
          [to_timeline_event] +
          memberships_events.map(&:to_timeline_event) +
          memberships_events.map(&:to_timeline_event)
        ].flatten.sort
      end

      def to_timeline_event
        Timeline::Event.new(title: t(".birth"), description: human, happened_at: birthdate)
      end

      def age
        age = Time.zone.now.year - birthdate.year
        age -= 1 if (Time.zone.now.month < birthdate.month) || (Time.zone.now.month == birthdate.month && birthdate.day >= Time.zone.now.day)
        age
      end

      def fullname
        "#{firstname} #{lastname}"
      end

      def human
        fullname
      end

      module AddressableConcern
        extend ActiveSupport::Concern

        included do
          has_many :addresses, class_name: "Tfc::Mdm::Addresses::Address", as: :record
        end

        def current_address
          addresses.joins(:role).order(created_at: :desc).where("tfc_mdm_addresses_roles.identifier": "primary_address").first
        end
      end

      include AddressableConcern
    end
  end
end
