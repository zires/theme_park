require 'helper'
require 'theme_park/rails/asset_tag_helper'

class ActionViewTest < ActionView::TestCase
  tests ThemePark::Rails::AssetTagHelper

  def setup
    super
    @current_theme = 'foo'
  end

  def test_stylesheet_link_tag
    assert_dom_equal '<link href="/stylesheets/xx.css" type="text/css" media="screen" rel="stylesheet"/>', stylesheet_link_tag('xx')
  end

  def test_javascript_include_tag
    assert_dom_equal '<script src="/javascripts/xx.js" type="text/javascript"></script>', javascript_include_tag('xx')
  end

  def test_image_tag
    assert_dom_equal '<img alt="Xx" src="/images/xx.jpg" />', image_tag('xx.jpg')
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

  def test_javascript_include_tag
    assert_dom_equal '<script src="/themes/foo/xx.js" type="text/javascript"></script>', javascript_include_tag('xx')
  end

  def test_stylesheet_link_tag
    assert_dom_equal '<link href="/themes/foo/xx.css" type="text/css" media="screen" rel="stylesheet"/>', stylesheet_link_tag('xx')
  end

  def test_image_tag
    assert_dom_equal '<img alt="Xx" src="/themes/foo/xx.jpg" />', image_tag('xx.jpg')
  end

end

class ActionViewServeThemeCompiledTest < ActionView::TestCase
  tests ThemePark::Rails::AssetTagHelper
  
  include Sprockets::Helpers::RailsHelper

  def setup
    super
    @current_theme = 'foo'
    Dummy::Application.config.assets.digest = true
  end

  def test_javascript_include_tag
    assert_dom_equal '<script src="/themes/foo/xx.js" type="text/javascript"></script>', javascript_include_tag('xx')
  end

  def test_stylesheet_link_tag
    assert_dom_equal '<link href="/themes/foo/xx.css" type="text/css" media="screen" rel="stylesheet"/>', stylesheet_link_tag('xx')
  end

  def test_image_tag
    assert_dom_equal '<img alt="Xx" src="/themes/foo/xx.jpg" />', image_tag('xx.jpg')
  end

  def teardown
    Dummy::Application.config.assets.digest = false
  end

end
