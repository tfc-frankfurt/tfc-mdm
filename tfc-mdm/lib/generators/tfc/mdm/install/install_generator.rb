# frozen_string_literal: true

module Tfc
  module Mdm
    module Generators
      class InstallGenerator < Rails::Generators::Base
        desc "Generates the initializer"

        source_root File.expand_path("../templates", __FILE__)

        attr_reader :base_controller_class_name, :user_class_name

        def initialize(*args)
          super
          @base_controller_class_name = ENV.fetch("TFC_MDM_BASE_CONTROLLER_CLASS_NAME") { "::ApplicationController" }
          @user_class_name = ENV.fetch("TFC_MDM_USER_CLASS_NAME") { "User" }
        end

        def generate_initializer
          template "initializer.rb", "config/initializers/tfc-mdm.rb"
        end

        def generate_routes
          route File.read(File.join(File.expand_path("../templates", __FILE__), "routes.source"))
        end
      end
    end
  end
end
