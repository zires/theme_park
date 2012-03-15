require 'helper'

class RailtieTest < ActiveSupport::TestCase

  test 'rails app should have a theme_park option' do
    theme_park = Dummy::Application.config.theme_park
    assert_equal(ThemePark, theme_park)
    assert_equal('themes', theme_park.prefix)
    assert_equal("#{Dummy::Application.root}/themes", theme_park.base_root)
  end

  test 'action_view should load ThemePark::Rails::ActionView' do
    assert ActionView::Helpers::AssetTagHelper < ThemePark::Rails::AssetTagHelper
  end

  test 'action_controller should load ThemePark::Rails::ActionController' do
    assert ActionController::Base < ThemePark::Rails::ActionController
  end

  test 'config.assets.paths should include ThemePark.assets_path' do
    assert Dummy::Application.config.assets.paths.include?("#{File.dirname(__FILE__)}/dummy/themes/default/assets/images")
  end

  test 'rails app route should mount at #{ThemePark.prefix}/:theme_name' do
    routes = Dummy::Application.routes.routes
    server = routes.select { |r| r.app.instance_of?(ThemePark::Rails::Server) }.pop
    assert !server.nil? # mount successful
    path   = server.path.spec.to_s
    assert_equal('/themes/:theme_name', path) # mount path correct
  end

end