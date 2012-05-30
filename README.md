## theme_park

theme_park is a flexible multiple theme plugin for rails3, sinatra, and more...it's rack based

### Getting started (Rails.version > 3)

Add it to your Gemfile.

```console
gem 'theme_park'
```

Install it use bundler command.

```console
bundle install
```

You can create a initializer file.

```console
rails generate theme_park:install
```

Now, let's create our first theme.

```console
rails generate theme_park:create dark
```

It will create the theme dir under the theme_park root path.

```
app/
- themes
  - [theme_name]
    |- assets
      |- images
      |- javascripts
      |- stylesheets
      |- compiled           -> Compiled static files
    |- views
      |- layouts
```

Use this theme in controller.

```ruby
class MyController < ApplicationController
  theme "dark", :only => :index
end
```

```ruby
class MyController < ApplicationController
  def index
    theme 'dark'
  end
end
```

Like rails3.1 need precompile asset files in the production environment, we need precompile theme asset files.

```console
rake theme_park:precompile theme=dark
```

or precompile all themes

```console
rake theme_park:precompile
```

### Configuration

See theme_park initializer file for more details.

```
config.root             = '/themes'
config.handlers         = :all           # will load all handlers depends on your application.
# other options for handlers
# config.handlers       = [:liquid]      # only load .liquid
# config.handlers       = [:erb, :haml]  # only load .erb and .haml
config.prefix           = 'themes'
config.images_path      = ':root/:name/assets/images'
config.javascripts_path = ':root/:name/assets/javascripts'
config.stylesheets_path = ':root/:name/assets/stylesheets'
config.compiled_path    = ':root/:name/assets/compiled'
config.views_path       = ':root/:name/views'
```

### Contributing to theme_park
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet.
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it.
* Fork the project.
* Start a feature/bugfix branch.
* Commit and push until you are happy with your contribution.
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

### Copyright

Copyright (c) 2012 Thierry Zires. See LICENSE.txt for further details.

