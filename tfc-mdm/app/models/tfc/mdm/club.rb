# frozen_string_literal: true

module Tfc
  module Mdm
    class Club < ActiveRecord::Base
      include SimpleFormPolymorphicAssociations::Model::AutocompleteConcern
      extend FriendlyId

      friendly_id :name, use: [:slugged]

      belongs_to :establishment
      has_many :membership_agreements, dependent: :restrict_with_error
      has_many :membership_cancellations, dependent: :restrict_with_error
      has_many :people, through: :membership_agreements, dependent: :restrict_with_error
      has_many :branches, dependent: :restrict_with_error

      has_one_attached :logo
      has_one_attached :favicon

      validates :establishment, :name, presence: true
      validates :name, uniqueness: true

      autocomplete scope: ->(matcher) { where("tfc_mdm_clubs.name LIKE :term", term: "%#{matcher.downcase}%") }, id_method: :id, text_method: :human

      def events
        [
          [Tfc::Mdm::ClubEstablished.new(club: self, happened_at: established_at, color: "#cce5ff")] +
            membership_agreements.map(&:to_event) +
            membership_cancellations.map(&:to_event)
        ].flatten.sort
      end

      def active_memberships
        membership_agreements.includes(:membership_cancellation).where(tfc_mdm_membership_cancellations: { membership_agreement_id: nil })
      end

      def active_members_count
        active_memberships.count("tfc_mdm_membership_agreements.id")
      end

      def active_members_average_age
        ages = active_memberships.map(&:person).map(&:age)
        return 0 if ages.empty?
        ages.instance_eval { reduce(:+) / size.to_f }
      end

      def established_at
        establishment.happened_at
      end

      def human
        name
      end

      module AddressableConcern
        extend ActiveSupport::Concern

        included do
          has_many :addresses, class_name: "Tfc::Mdm::Addresses::Address", as: :record, dependent: :destroy
          has_many :address_roles, class_name: "Tfc::Mdm::Addresses::Role", inverse_of: :club, dependent: :destroy
        end

        def current_address
          addresses.joins(:role).order(created_at: :desc).where("tfc_mdm_addresses_roles.identifier": "primary_address").first
        end
      end

      include AddressableConcern

      module CreateFromEstablishmentConcern
        extend ActiveSupport::Concern

        included do
          before_validation :set_attributes_from_establishment, if: ->(resource) { resource.new_record? && resource.establishment.present? }
        end

        private

          def set_attributes_from_establishment
            self.name ||= establishment.name
          end
      end

      include CreateFromEstablishmentConcern
    end
  end
end
