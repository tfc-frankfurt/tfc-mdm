module Tfc::Mdm
  module Memberships
    class Category < ApplicationRecord
      include Tfc::Mdm::Model::ValueTranslationConcern

      belongs_to :club, class_name: 'Tfc::Mdm::Club'
      has_many :memberships, class_name: 'Tfc::Mdm::Memberships::Membership'
      has_many :fees, class_name: 'Tfc::Mdm::Memberships::Fee', dependent: :destroy
      has_one :current_fee, -> { active }, class_name: 'Tfc::Mdm::Memberships::Fee'

      validates :identifier, presence: true, uniqueness: { scope: :club_id }

      def human
        [club.human, identifier, current_fee&.amount].compact.join(" - ")
      end
    end
  end
end
