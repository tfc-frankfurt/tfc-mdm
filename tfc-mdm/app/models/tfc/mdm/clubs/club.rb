# frozen_string_literal: true

module Tfc
  module Mdm
    module Clubs
      class Club < ActiveRecord::Base
        include SimpleFormPolymorphicAssociations::Model::AutocompleteConcern
        extend FriendlyId

        friendly_id :name, use: [:slugged]

        belongs_to :establishment
        has_many :bank_details, class_name: "Tfc::Mdm::Clubs::BankDetail", dependent: :destroy
        has_one :primary_bank_detail, -> { where(role: "primary") }, class_name: "Tfc::Mdm::Clubs::BankDetail"
        has_many :email_addresses, class_name: "Tfc::Mdm::Clubs::EmailAddress", dependent: :destroy
        has_one :primary_email_address, -> { where(role: "primary") }, class_name: "Tfc::Mdm::Clubs::EmailAddress"
        has_many :phone_numbers, class_name: "Tfc::Mdm::Clubs::PhoneNumber", dependent: :destroy
        has_one :primary_phone_number, -> { where(role: "primary") }, class_name: "Tfc::Mdm::Clubs::PhoneNumber"
        has_many :social_media, class_name: "Tfc::Mdm::Clubs::SocialMedium", dependent: :destroy
        has_one :social_media_website, -> { where(platform: "www") }, class_name: "Tfc::Mdm::Clubs::SocialMedium"
        has_many :membership_agreements, dependent: :restrict_with_error
        has_many :membership_cancellations, dependent: :restrict_with_error
        has_many :branches, dependent: :restrict_with_error
        has_many :memberships_categories, dependent: :restrict_with_error, class_name: "Tfc::Mdm::Memberships::Category"
        has_many :memberships, class_name: "Tfc::Mdm::Memberships::Membership"
        has_many :memberships_events, through: :memberships, class_name: "Tfc::Mdm::Memberships::Event", source: :events
        has_many :people, through: :memberships, dependent: :restrict_with_error
        has_many :positions, -> { order(position: :asc) }, class_name: "Tfc::Mdm::Positions::Position", dependent: :destroy

        has_one_attached :logo
        has_one_attached :favicon

        validates :establishment, :name, presence: true
        validates :name, uniqueness: true

        autocomplete scope: ->(matcher) { where("lower(tfc_mdm_clubs_clubs.name) LIKE :term", term: "%#{matcher.downcase}%") }, id_method: :id, text_method: :human

        def events
          [
            [to_timeline_event] +
              memberships_events.map(&:to_timeline_event)
          ].flatten.sort
        end

        def to_timeline_event
          Timeline::Event.new(title: Tfc::Mdm::Establishment.model_name.human, description: human, happened_at: established_at, color: "#cce5ff")
        end

        def active_members_count
          memberships.active.count
        end

        def active_members_average_age
          ages = memberships.active.map(&:person).map(&:age)
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
end
