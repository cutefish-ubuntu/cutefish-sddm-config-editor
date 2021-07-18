module SDDMConfigurationEditor
  module SettingConversion
    def self.normalize_string(value)
      if value.respond_to? :str
        value = value.str
      elsif value == []
        value = ''
      end
      value.strip
    end

    def self.convert(key, value)
      key = normalize_string(key)
      value = normalize_string(value)

      case value
      when /\d+/
        [:integer, key, value]
      when /^true|false$/
        [:boolean, key, value]
      when %r(^/[^:]+:)
        [:path_list, key, value]
      when %r(^/)
        type =
          if !value.empty? && File.directory?(value)
            :directory
          else
            :file
          end
        [type, key, value]
      when []
        [:string, key, '']
      else
        [:string, key, value]
      end
    end
  end
end

