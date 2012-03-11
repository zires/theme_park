# encoding: utf-8
require 'action_dispatch/middleware/static'

module ThemePark
  module Rails
    class Server < ThemePark::Server

      # Only for Rails application.
      def call(env)
        theme_name = env['action_dispatch.request.path_parameters'][:theme_name]
        path       = ThemePark.compiled_path(theme_name)
        ActionDispatch::Static.new(@app, path, @cache_control).call(env)
      end

    end
  end
end