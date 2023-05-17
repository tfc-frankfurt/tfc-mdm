# Tfc::Mdm::Backend

## Prerequisites

Make sure you have installed the tfc_mdm gem.

## Installation

Add it to you gemfile:

    # Gemfile
    gem 'tfc_mdm_backend'

Install your bundle:

    #> bundle install

Install the initializer and routes:

    #> rails g tfc:mdm:backend:install

Register the engine in administrador:

    # config/initializers/administrador.rb
    Administrador.configure do |config|
      config.register_engine 'Tfc::Mdm::Backend::Engine', {}
    end

## License

This project rocks and uses MIT-LICENSE.