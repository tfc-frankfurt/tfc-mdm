# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  helper :"ResourceRenderer::View"
  default from: "info@tfc-frankfurt.de"
  layout "tfc/mdm/mailer"
end
