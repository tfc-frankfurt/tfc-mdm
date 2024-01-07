module Tfc::Mdm
  class Memberships::Fee < ApplicationRecord
    include Tfc::Mdm::Model::ActiveConcern

    belongs_to :category
    has_one :club, through: :category, class_name: "Tfc::Mdm::Club"

    scope :for_month, ->(month) { where("active_from <= ? AND active_to >= ?", month.end_of_month, month.beginning_of_month) }

    register_currency Tfc::Mdm::Configuration.default_currency
    monetize :amount_cents, numericality: { greater_than_or_equal_to: 0 }
  end
end
