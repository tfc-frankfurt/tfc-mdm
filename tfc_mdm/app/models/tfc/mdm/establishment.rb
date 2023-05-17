# frozen_string_literal: true

module Tfc
  module Mdm
    class Establishment < ActiveRecord::Base
      has_one :club

      validates :name, presence: true
      validates :happened_at, presence: true
      validates :line1, presence: true
      validates :street, presence: true
      validates :zipcode, presence: true
      validates :city, presence: true
      validates :country, presence: true

      has_one_attached :logo # , attachment_content_type: { in: %w[image/svg+xml] }

      def human
        "#{name} - #{I18n.l(happened_at)} - #{city}"
      end
    end
  end
end
