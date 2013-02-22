# encoding: utf-8
require 'rack/utils'

module ThemePark
  # This is a rack middleware handles static file request.
  # For generic rack application.
  # The theme url may like this: {ThemePark.prefix}/{theme_name}/{resource_name}
  # Example:
  # /themes/default/application.js
  class Server
    
    def initialize(app, cache_control = nil)
      @app = app
      @cache_control = cache_control
    end

    def call(env)
      request    = Rack::Request.new(env)
      theme_name = request.params['theme_name']
      path       = ThemePark.compiled_path(theme_name)
      ::Rack::File.new(path, @cache_control)
    end

    private

    # Copy form ::Rack::File#fail
    def fail(status, body)
      body += "\n"
      [
        status,
        {
          "Content-Type" => "text/plain",
          "Content-Length" => body.size.to_s,
          "X-Cascade" => "pass"
        },
        [body]
      ]
    end

  end
end
