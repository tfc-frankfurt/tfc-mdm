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

# Setup Webpacker
sed -i '17i\require "webpacker"' config/application.rb
rails webpacker:install

# Setup sprockets-rails
sed -i '17i\require "sprockets/rails"' config/application.rb

# Setup ActiveStorage
rails active_storage:install

# Setup ActiveRecord encryption
sed -i '/end/i\  config.active_record.encryption.primary_key = "test"' config/environments/test.rb
sed -i '/end/i\  config.active_record.encryption.deterministic_key = "test"' config/environments/test.rb
sed -i '/end/i\  config.active_record.encryption.key_derivation_salt = "test"' config/environments/test.rb

# Setup i18n
touch config/initializers/i18n.rb
echo "Rails.application.config.i18n.available_locales = [:en, :de]" >> config/initializers/i18n.rb
echo "Rails.application.config.i18n.default_locale    = :de" >> config/initializers/i18n.rb

# Setup dummy app
rails generate model User email password_digest active:boolean confirmed:boolean approved:boolean

# Setup cmor-core-settings
rails generate cmor:core:settings:install
rails cmor_core_settings:install:migrations

# Setup cmor-core-api
rails generate cmor:core:api:install
rails cmor_core_api:install:migrations

# Setup cmor-translations
rails cmor_translations:install:migrations

# Setup tfc_mdm
rails generate tfc:mdm:install
rails tfc_mdm:install:migrations db:migrate db:test:prepare

# Setup tfc-mdm-api
rails generate tfc:mdm:api:install
