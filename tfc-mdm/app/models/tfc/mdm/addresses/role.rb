# frozen_string_literal: true

module Tfc
  module Mdm
    class Addresses::Role < ApplicationRecord
      belongs_to :club
      has_many :addresses

      validates :identifier, presence: true, uniqueness: true

      def human
        identifier
      end
    end
  end
end
