# frozen_string_literal: true

require "much-config/version"
require "much-mixin"

module MuchConfig
  include MuchMixin

  def self.classify(term)
    # prefer to ActiveSupport if present
    return term.classify if term.respond_to?(:classify)

    value = term.sub(/^[a-z\d]*/, &:capitalize)
    value.gsub!(%r{(?:_|(/))([a-z\d]*)}i) do
      "#{Regexp.last_match(1)}#{Regexp.last_match(2).capitalize}"
    end
    value.gsub!("/", "::")
    value
  end

  def self.underscore(cased_term)
    # prefer to ActiveSupport if present
    return cased_term.underscore if cased_term.respond_to?(:underscore)

    return cased_term unless /[A-Z-]|::/.match?(cased_term)

    term = cased_term.to_s.gsub("::", "/")
    term.gsub!(/([A-Z\d]+)([A-Z][a-z])/, '\1_\2')
    term.gsub!(/([a-z\d])([A-Z])/, '\1_\2')
    term.tr!("-", "_")
    term.downcase!
    term
  end

  mixin_class_methods do
    def add_config(name = nil, method_name: nil)
      config_method_name, config_class_name, configure_method_name =
        much_config_names(name, method_name)

      instance_eval(<<~RUBY, __FILE__, __LINE__ + 1)
        def #{config_method_name}
          @#{config_method_name} ||= self::#{config_class_name}.new
        end

        def #{configure_method_name}
          yield(#{config_method_name}) if block_given?
        end
      RUBY
    end

    def add_instance_config(name = nil, method_name: nil)
      config_method_name, config_class_name, configure_method_name =
        much_config_names(name, method_name)

      instance_eval(<<~RUBY, __FILE__, __LINE__ + 1)
        define_method(:#{config_method_name}) do
          @#{config_method_name} ||= self.class::#{config_class_name}.new
        end

        define_method(:#{configure_method_name}) do |&block|
          block.call(#{config_method_name}) if block
        end
      RUBY
    end

    private

    def much_config_names(name, method_name)
      name_prefix = name.nil? ? "" : "#{MuchConfig.underscore(name.to_s)}_"
      config_method_name = (method_name || "#{name_prefix}config").to_s
      config_class_name = "#{MuchConfig.classify(name_prefix)}Config"

      name_suffix = name.nil? ? "" : "_#{MuchConfig.underscore(name.to_s)}"
      configure_method_name = "configure#{name_suffix}"

      [config_method_name, config_class_name, configure_method_name]
    end
  end
end
