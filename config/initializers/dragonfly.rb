require 'dragonfly'

# Configure
Dragonfly.app.configure do
  plugin :imagemagick

  secret "94388b29a3ec5ba1fa00470c4f97aa9a6fc7e31d6592f714b17c8429feffce4f"

  url_format "/media/:job/:name"

  datastore :file,
    root_path: Rails.root.join('public/system/dragonfly', Rails.env),
    server_root: Rails.root.join('public')
end

# Logger
Dragonfly.logger = Rails.logger

# Mount as middleware
Rails.application.middleware.use Dragonfly::Middleware

# Add model functionality
ActiveSupport.on_load(:active_record) do
  extend Dragonfly::Model
  extend Dragonfly::Model::Validations
end
