# frozen_string_literal: true

module Tfc
  module Mdm
    class Addresses::Role < ApplicationRecord
      has_many :addresses

      validates :identifier, presence: true, uniqueness: true
    end
  end
end
