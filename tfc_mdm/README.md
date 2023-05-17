# Tfc::Mdm

This a master data management module for clubs.

## Installation

Add it to you gemfile:

    # Gemfile
    gem 'tfc_mdm'

Install your bundle:

    #> bundle install

Install the migrations and migrate:

    #> rails tfc_mdm:install:migrations
    #> rails db:migrate && rails db:test:prepare

Install the initialier and routes:

    #> rails g tfc:mdm:install

## License

This project rocks and uses MIT-LICENSE.