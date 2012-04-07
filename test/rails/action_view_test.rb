require 'helper'
require 'theme_park/rails/asset_tag_helper'

class ActionViewTest < ActionView::TestCase
  tests ThemePark::Rails::AssetTagHelper

  def setup
    super
    @current_theme = 'foo'    
  end

  def test_theme_stylesheet_link_tag
    assert_dom_equal '<link href="/stylesheets/xx.css" type="text/css" media="screen" rel="stylesheet"/>', theme_stylesheet_link_tag('xx')
  end

  def test_theme_javascript_include_tag
    assert_dom_equal '<script src="/javascripts/xx.js" type="text/javascript"></script>', theme_javascript_include_tag('xx')
  end

  def test_theme_image_tag
    assert_dom_equal '<img alt="Xx" src="/images/xx.jpg" />', theme_image_tag('xx.jpg')
  end

  def test_theme_compiled_path
    assert_equal "/themes/foo/bar.js", theme_compiled_path('bar.js')
    assert_equal "/themes/foo1/bar.js", theme_compiled_path('bar.js', 'foo1')
  end

  def test_assets_enabled?
    assert_equal true, assets_enabled?
  end

  def test_serve_static_assets?
    assert_equal true, serve_static_assets?
  end

  def test_assets_digest?
    assert_equal false, assets_digest?
  end

  def test_serve_theme_compiled?
    assert_equal false, serve_theme_compiled?
  end

  def test_current_theme
    assert_equal 'foo', current_theme
  end

end

class ActionViewUseSprocketsTest < ActionView::TestCase
  tests ThemePark::Rails::AssetTagHelper

  include Sprockets::Helpers::RailsHelper

  def setup
    super
    @current_theme = 'foo'    
  end

  def test_theme_javascript_include_tag
    assert_dom_equal '<script src="/assets/xx.js" type="text/javascript"></script>', theme_javascript_include_tag('xx')
  end

  def test_theme_stylesheet_link_tag
    assert_dom_equal '<link href="/assets/xx.css" type="text/css" media="screen" rel="stylesheet"/>', theme_stylesheet_link_tag('xx')
  end

  def test_theme_image_tag
    assert_dom_equal '<img alt="Xx" src="/assets/xx.jpg" />', theme_image_tag('xx.jpg')
  end

end

class ActionViewServeThemeCompiledTest < ActionView::TestCase
  tests ThemePark::Rails::AssetTagHelper
  
  def setup
    super
    @current_theme = 'foo'
    Dummy::Application.config.assets.digest = true
  end

  def test_theme_javascript_include_tag
    assert_dom_equal '<script src="/themes/foo/xx.js" type="text/javascript"></script>', theme_javascript_include_tag('xx')
    assert_dom_equal '<script src="/themes/bar/xx.js" type="text/javascript"></script>', theme_javascript_include_tag('xx', :theme => 'bar')
  end

  def test_theme_stylesheet_link_tag
    assert_dom_equal '<link href="/themes/foo/xx.css" type="text/css" media="screen" rel="stylesheet"/>', theme_stylesheet_link_tag('xx')
    assert_dom_equal '<link href="/themes/bar/xx.css" type="text/css" media="screen" rel="stylesheet"/>', theme_stylesheet_link_tag('xx', :theme => 'bar')
  end

  def test_theme_image_tag
    assert_dom_equal '<img alt="Xx" src="/themes/foo/xx.jpg" />', theme_image_tag('xx.jpg')
    assert_dom_equal '<img alt="Xx" src="/themes/bar/xx.jpg" />', theme_image_tag('xx.jpg', :theme => 'bar')
  end

  def teardown
    Dummy::Application.config.assets.digest = false
  end

end