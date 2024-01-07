module Tfc::Mdm
  class Memberships::EventType < ApplicationRecord
    include Tfc::Mdm::Model::IdentifierConcern
    include Tfc::Mdm::Model::ValueTranslationConcern

    has_many :events
    has_many :memberships, through: :events

    def human
      self.class.human_value_name(:identifier, identifier, count: :one)
    end

    def memberships_count
      memberships.count
    end

    def color
      case identifier
      when "agreement"
        "#28a745"
      when "termination"
        "#dc3545"
      end
    end
  end
end
