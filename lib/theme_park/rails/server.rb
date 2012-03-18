# encoding: utf-8
require 'action_dispatch/middleware/static'

module ThemePark
  module Rails
    class Server < ThemePark::Server

      # Only for Rails application.
      def call(env)
        path        = env['PATH_INFO'].chomp('/')
        theme_name  = env['action_dispatch.request.path_parameters'][:theme_name]
        lookup_path = ThemePark.compiled_path(theme_name)
        if File.file?( File.join(lookup_path, path) )
          ActionDispatch::Static.new(@app, lookup_path, @cache_control).call(env)
        else
          # Need return 404
          fail(404, "File not found: #{path}")
        end
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
end