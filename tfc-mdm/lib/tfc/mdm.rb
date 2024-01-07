require "acts_as_list"
require "acts_as_published"
require "bgit-invoicing"
require "cmor-translations"
require "coffee-rails"
require "friendly_id"
require "geocoder"
require "money-rails"
require "rao-active_collection"
require "rao-component"
require "rao-resources_controller"
require "rao-service"
require "route_translator"
require "simple_form-fake_inputs"
require "simple_form-polymorphic_associations"

require "tfc/mdm/configuration"
require "tfc/mdm/engine"
require "tfc/mdm/version"

module Tfc
  module Mdm
    extend Configuration
  end
end
