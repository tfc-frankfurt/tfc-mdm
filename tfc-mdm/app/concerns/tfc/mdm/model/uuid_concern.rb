module Tfc
  module Mdm
    module Model
      module UuidConcern
        extend ActiveSupport::Concern

        included do
          after_initialize :set_uuid
          validates :uuid, presence: true, uniqueness: true
        end

        private

        def set_uuid
          self.uuid ||= SecureRandom.uuid
        end
      end
    end
  end
end
