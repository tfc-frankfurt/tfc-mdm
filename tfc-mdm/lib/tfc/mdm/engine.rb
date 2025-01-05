module Tfc
  module Mdm
    class Engine < ::Rails::Engine
      isolate_namespace Tfc::Mdm

      config.generators do |g|
        g.test_framework :rspec
        g.fixture_replacement :factory_bot
        g.factory_bot dir: 'spec/factories'
      end

      # Inject Tfc::Mdm::Model::UserConcern into the user class.
      # This is done in a to_prepare block to make sure the user class is loaded
      # before we try to include the concern.
      config.to_prepare do
        blck = -> do
          print "[Tfc::Mdm::Engine] injecting Tfc::Mdm::Model::UserConcern into #{Tfc::Mdm::Configuration.user_class_name}"
          begin
            Tfc::Mdm::Configuration.user_class_name.constantize.send(:include, Tfc::Mdm::Model::UserConcern)
            puts " => [OK]"
          rescue NameError => e
            puts " => [FAILED] #{e.message}"
          end
        end

        # If we are in the test environment, we can inject the concern right away.
        # If we use ActiveSupport.on_load(:active_record) in the test environment,
        # we the User class into which we want to inject the concern might not be
        # loaded yet. This leads to a NameError.
        # It seems like ActiveSupport.on_load(:active_record) works differently in the
        # test environment than in the development/production environment.
        if Rails.env.test?
          blck.call
        else
          ActiveSupport.on_load(:active_record) do
            blck.call
          end
        end
      end
    end
  end
end
