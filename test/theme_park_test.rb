require 'helper'

class ThemeParkTest < TestCase

  def test_root
    assert_equal("#{@logic_path}/themes", ThemePark.root)
  end

  def test_prefix
    assert_equal("themes", ThemePark.prefix)
  end

  def test_path_with_theme_name
    assert_equal("#{@logic_path}/themes/default", ThemePark.path('default'))
  end

  def test_theme_exist_or_not
    assert_equal(true, ThemePark.exist?('default'))
    assert_equal(false, ThemePark.exist?('foo'))
  end

  def test_interpolate
    assert_equal("#{@logic_path}/themes/oo/bar/foo", ThemePark.interpolate(':root/oo/:name/foo', 'bar'))
    assert_equal("/themes/oo/bar/foo", ThemePark.interpolate('/themes/oo/bar/foo', 'bar'))
  end

  def test_images_path
    assert_equal("#{@logic_path}/themes/default/assets/images", ThemePark.images_path('default'))
  end

  def test_javascripts_path
    assert_equal("#{@logic_path}/themes/default/assets/javascripts", ThemePark.javascripts_path('default'))
  end

  def test_stylesheets_path
    assert_equal("#{@logic_path}/themes/default/assets/stylesheets", ThemePark.stylesheets_path('default'))
  end

  def test_compiled_path
    assert_equal("#{@logic_path}/themes/default/assets/compiled", ThemePark.compiled_path('default'))
  end

  def test_views_path
    assert_equal("#{@logic_path}/themes/default/views", ThemePark.views_path('default'))
  end

  def test_assets_path_for_one_theme
    assets_path = [ "#{@logic_path}/themes/default/assets/images", 
                    "#{@logic_path}/themes/default/assets/javascripts", 
                    "#{@logic_path}/themes/default/assets/stylesheets"]
    assert_equal(assets_path, ThemePark.theme_assets_path('default'))
  end

  def test_assets_path
    assets_path = [ "#{@logic_path}/themes/default/assets/images",
                    "#{@logic_path}/themes/default/assets/javascripts",
                    "#{@logic_path}/themes/default/assets/stylesheets",
                    "#{@logic_path}/themes/default1/assets/images",
                    "#{@logic_path}/themes/default1/assets/javascripts",
                    "#{@logic_path}/themes/default1/assets/stylesheets"].sort
    assert_equal(assets_path, ThemePark.assets_path.sort)     
  end
  
end