Rails.application.routes.draw do
  mount TfcMdmApi::Engine => "/tfc_mdm_api"
end
