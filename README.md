# MuchConfig

Configuration for Ruby objects.

## Usage

Mixin MuchConfig in your e.g. `MyClass` Ruby object. Call the `add_config` DSL method and define `MyClass::Config`:

```ruby
module MyClass
  include MuchConfig

  add_config

  def self.value1
    config.value1
  end

  class Config
    attr_accessor :value1

    def initialize
      @value1 = "default value for `value1`"
    end
  end
end
```

Configure MyClass using the MuchConfig API:

```ruby
MyClass.config.value1 = "a custom value"

# OR

MyClass.configure do |config|
  config.value1 = "a custom value"
end
```

### Define multiple named configs

You can define multiple named configs, e.g.:

```ruby
module MyClass
  include MuchConfig

  add_config :values
  add_config :settings

  def self.value1
    values_config.value1
  end

  def self.setting1
    settings_config.setting1
  end

  class ValuesConfig
    attr_accessor :value1

    def initialize
      @value1 = "default value for `value1`"
    end
  end

  class SettingsConfig
    attr_accessor :setting1

    def initialize
      @setting1 = "default value for `setting1`"
    end
  end
end
```

Configure using the MuchConfig API:

```ruby
MyClass.values_config.value1 = "a custom value"
MyClass.settings_config.setting1 = "a custom value"

# OR

MyClass.configure_values do |config|
  config.value1 = "a custom value"
end
MyClass.configure_settings do |config|
  config.setting1 = "a custom value"
end
```

## Installation

Add this line to your application's Gemfile:

    gem "much-config"

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install much-config

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am "Added some feature"`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
