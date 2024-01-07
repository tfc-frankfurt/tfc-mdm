module Tfc
  module Mdm
    module Model
      module UserConcern
        extend ActiveSupport::Concern
  
        included do
          has_one :person, class_name: "Tfc::Mdm::Person", foreign_key: :user_id, inverse_of: :user, dependent: :nullify
          has_many :memberships, class_name: "Tfc::Mdm::Memberships::Membership", through: :person
        end
      end
    end
  end
end
