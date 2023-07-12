module Tfc::Mdm
  class Achievements::Achievement < ApplicationRecord
    include ActsAsPublished::ActiveRecord

    belongs_to :club
    belongs_to :category
    belongs_to :achiever, polymorphic: true

    has_one_attached :image

    acts_as_list scope: :category
    acts_as_published
  end
end
