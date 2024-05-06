# frozen_string_literal: true

module Tfc
  module Mdm
    class Addresses::Role < ApplicationRecord
      include Tfc::Mdm::Model::ValueTranslationConcern

      belongs_to :club, class_name: "Tfc::Mdm::Clubs::Club"
      has_many :addresses, inverse_of: :role

      validates :identifier, presence: true, uniqueness: { scope: :club_id }

      scope :identified_by, ->(identifier) { where(identifier: identifier) }

      def human
        identifier
      end
    end
  end
end
