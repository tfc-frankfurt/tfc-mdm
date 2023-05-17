# frozen_string_literal: true

module Tfc
  module Mdm
    module Api
      class MembershipCancellationsController < ::Tfc::Mdm::Api::ResourcesController::Base
        def self.resource_class
          Tfc::Mdm::MembershipCancellation
        end

        private

          def load_collection_scope
            super.includes(:club, :person, :membership_agreement)
          end

          def permitted_params
            params.require(:membership_cancellation).permit(:membership_agreement_id, :entry_at)
          end
      end
    end
  end
end
