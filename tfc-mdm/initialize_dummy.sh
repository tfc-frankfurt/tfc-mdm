#!/bin/bash

# Delete old dummy app
rm -rf spec/dummy

# Generate new dummy app
DISABLE_MIGRATE=true rake dummy:app

if [ ! -d "spec/dummy/config" ]; then exit 1; fi

# Cleanup
rm spec/dummy/.ruby-version
rm spec/dummy/Gemfile

cd spec/dummy

# Use correct Gemfile
sed -i "s|../Gemfile|../../../Gemfile|g" config/boot.rb

# Setup Webpacker/Asset Pipeline
sed -i '17i\require "webpacker"' config/application.rb
sed -i '17i\require "sprockets/rails"' config/application.rb
rails webpacker:install

# Setup ActiveStorage
rails active_storage:install

# Setup i18n
touch config/initializers/i18n.rb
echo "Rails.application.config.i18n.available_locales = [:en, :de]" >> config/initializers/i18n.rb
echo "Rails.application.config.i18n.default_locale    = :de" >> config/initializers/i18n.rb

# Setup i18n routing
touch config/initializers/route_translator.rb
echo "RouteTranslator.config do |config|" >> config/initializers/route_translator.rb
echo "  config.force_locale = true" >> config/initializers/route_translator.rb
echo "end" >> config/initializers/route_translator.rb

# Setup dummy app
rails generate model User email password_digest active:boolean confirmed:boolean approved:boolean
# add password confiirmation to user model
sed -i '2i\  has_secure_password :password' app/models/user.rb
# add current_user method to the application controller
sed -i '2i\  def current_user; end' app/controllers/application_controller.rb

# Setup cmor-core-settings
rails generate cmor:core:settings:install
rails cmor_core_settings:install:migrations

# Setup cmor_translations
rails cmor_translations:install:migrations

# Setup tfc-mdm
rails generate tfc:mdm:install
rails tfc_mdm:install:migrations

# Setup database
rails db:migrate db:test:prepare