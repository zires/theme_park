require 'helper'

class TestController < ApplicationController
  theme 'default'
  
  def index
  end
  
end

class Test1Controller < ApplicationController
  theme 'default', :only => :show

  def index
  end

  def show
  end

  def edit
    theme 'default1'
  end

end

class TestControllerTest < ActionController::TestCase
  
  tests TestController

  def test_class_method_theme_without_options
    get :index
    assert @response.body.include?('default/test/index.html.erb')
    assert_equal 'default', assigns('current_theme')
  end

end

class Test1ControllerTest < ActionController::TestCase

  tests Test1Controller

  def test_class_method_theme_with_options
    get :index
    assert @response.body.include?('origin/test1/index.html.erb')
    assert_equal nil, assigns('current_theme')

    get :show
    assert @response.body.include?('default/test1/show.html.erb')
    assert_equal 'default', assigns('current_theme')
  end

  def test_instance_method_theme
    get :edit
    assert @response.body.include?('default1/test1/edit.html.erb')
    assert_equal 'default1', assigns('current_theme')
  end

end