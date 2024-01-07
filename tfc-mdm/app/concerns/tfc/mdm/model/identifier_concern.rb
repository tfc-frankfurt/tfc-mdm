module Tfc
  module Mdm
    module Model
      module IdentifierConcern
        extend ActiveSupport::Concern
  
        included do
          validates :identifier, presence: true, uniqueness: true
          scope :identified_by, ->(identifier) { where(identifier: identifier) }
        end
      end
    end
  end
end
