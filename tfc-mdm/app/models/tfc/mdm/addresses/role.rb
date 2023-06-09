# frozen_string_literal: true

module Tfc
  module Mdm
    class Addresses::Role < ApplicationRecord
      belongs_to :club
      has_many :addresses, inverse_of: :role

      validates :identifier, presence: true
      validates :identifier, uniqueness: { scope: [ :club_id ] }

      def human
        identifier
      end
    end
  end
end
