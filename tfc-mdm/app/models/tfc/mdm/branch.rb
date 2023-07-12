# frozen_string_literal: true

module Tfc
  module Mdm
    class Branch < ActiveRecord::Base
      belongs_to :club

      validates :club, :identifier, :valid_from, :valid_to, presence: true
      validates :identifier, uniqueness: { scope: [:club_id] }

      has_many_attached :assets

      scope :valid, -> { valid_at(Time.zone.now) }
      scope :valid_at, ->(moment) {
        where(arel_table["valid_from"].lteq(moment)).where(arel_table["valid_to"].gteq(moment))
      }

      def images
        assets.joins(:blob).where("active_storage_blobs.content_type LIKE '%image/%'")
      end

      def human
        name
      end

      module TranslatedAttributesConcern
        extend ActiveSupport::Concern

        included do
          after_save :write_translated_attributes
          after_destroy :destroy_translated_attributes
        end

        class_methods do
          def translated_attributes
            @translated_attributes ||= []
          end

          def translated_attributes=(value)
            @translated_attributes = value
          end

          def translated_attribute_accessor(*args)
            self.translated_attributes += args
            attr_accessor *args
            args.each do |attr_name|
            define_method(attr_name) do
              value = instance_variable_get("@#{attr_name}") || read_translated_attribute(attr_name)
              instance_variable_set("@#{attr_name}", value)
            end
          end
          end
        end

        private

          def i18n_key_for_attribute(attr_name)
            "activerecord.values.#{self.class.name.underscore}.#{self.id}.#{attr_name}"
          end

          def read_translated_attribute(attr_name)
            locale = I18n.locale
            key = i18n_key_for_attribute(attr_name)
            Cmor::Translations::Translation.where(locale: locale, key: key).first.try(:value)
          end

          def write_translated_attributes
            locale = I18n.locale
            self.class.translated_attributes.each do |attr_name|
              key = i18n_key_for_attribute(attr_name)
              value = instance_variable_get("@#{attr_name}")
              Cmor::Translations::Translation.where(locale: locale, key: key).first_or_initialize.tap do |t|
                t.value = value
                t.save!
              end
            end
          end

          def destroy_translated_attributes
            locale = I18n.locale
            keys = self.class.translated_attributes.collect do |attr_name|
              i18n_key_for_attribute(attr_name)
            end
            Cmor::Translations::Translation.where(locale: locale, key: keys).destroy_all
          end
      end

      include TranslatedAttributesConcern

      translated_attribute_accessor :name, :description


      def description(format = :default)
        value = read_translated_attribute(:description)
        case format
        when :html
          return unless value
          RedCloth.new(value).to_html.html_safe
        else
          value
        end
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
