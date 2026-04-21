Rails.application.routes.draw do
  # This is necessary for now since when we try to point at this gem via path or github repo, it brings in the whole
  # project directory structure and therefore tries to draw the routes
  if Rails.application.instance_of?(CfaUiComponents::Application)
    get "up" => "rails/health#show", :as => :rails_health_check
    mount Lookbook::Engine, at: "/"
  end
end
