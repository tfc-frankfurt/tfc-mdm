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
ARE_CONF=$(cat <<-END
active_record_encryption:
  primary_key: L65Ufyp4rGhy6Ljey0FURgzTxMfz5bmf
  deterministic_key: Wgxp51Q5mVF8zPjeCMx34Ve5FI5cA9WA
  key_derivation_salt: V0uzZUabwzurOw8HZmJbPC6XAFMGmedv
END
)

EDITOR="echo \"$ARE_CONF\" >> " rails credentials:edit

# Setup i18n
touch config/initializers/i18n.rb
echo "Rails.application.config.i18n.available_locales = [:en, :de]" >> config/initializers/i18n.rb
echo "Rails.application.config.i18n.default_locale    = :de" >> config/initializers/i18n.rb

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
