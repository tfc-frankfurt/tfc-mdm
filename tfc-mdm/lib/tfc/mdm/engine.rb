module Tfc
  module Mdm
    class Engine < ::Rails::Engine
      isolate_namespace Tfc::Mdm

      config.generators do |g|
        g.test_framework :rspec
        g.fixture_replacement :factory_bot
        g.factory_bot dir: 'spec/factories'
      end

      config.to_prepare do
        print "[Tfc::Mdm::Engine] injecting Tfc::Mdm::Model::UserConcern into #{Tfc::Mdm::Configuration.user_class_name}"
        begin
          Tfc::Mdm::Configuration.user_class_name.constantize.send(:include, Tfc::Mdm::Model::UserConcern)
          puts " => OK"
        rescue NameError => e
          puts " => [FAILED] #{e.message}"
        end
      end
    end
  end
end
