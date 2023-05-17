# frozen_string_literal: true

module Tfc
  module Mdm
    module Backend
      class Engine < ::Rails::Engine
        isolate_namespace Tfc::Mdm::Backend
      end
    end
  end
end
