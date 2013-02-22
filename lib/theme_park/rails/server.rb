# encoding: utf-8
require 'action_dispatch/middleware/static'

module ThemePark
  module Rails
    class Server < ThemePark::Server

      # Only for Rails application.
      def call(env)
        path        = env['PATH_INFO'].chomp('/')
        theme_name  = env['action_dispatch.request.path_parameters'][:theme_name]
        if env["QUERY_STRING"].to_s == "body=1"
          ThemePark.assets.call(env)
        else
          serve_compiled_path(theme_name, path, env)
        end
      end

      def serve_compiled_path(theme_name, path, env)
        lookup_path = ThemePark.compiled_path(theme_name)
        if File.file?( File.join(lookup_path, path) )
          ActionDispatch::Static.new(@app, lookup_path, @cache_control).call(env)
        else
          fail(404, "File not found: #{path}")
        end
      end

    end
  end
end
