# frozen_string_literal: true

require 'yaml_duplicate_checker/version'
require 'yaml'

module YamlDuplicateChecker
  # Yaml duplicate check class
  # @abstract
  #   Use Checker#dup_list returns duplicate yaml key list
  #
  class Checker
    def initialize(root)
      @key_list = Hash.new { |h, v| h[v] = [] }
      @root = root
      check
    end

    def dup_list
      @dup_list ||= @key_list.select { |_, v| v.size > 1 }
    end

    private

    def set_key_list(parsed_yaml, path, result_key = '')
      parsed_yaml.each_slice(2) do |k, v|
        unless v.mapping?
          update_key_list(result_key, k, path)
          next
        end

        next_key = result_key + format_key(k.value, result_key)
        set_key_list(v.children, path, next_key)
      end
    end

    def format_key(key, result_key)
      result_key == '' ? key : ".#{key}"
    end

    def check
      Dir.glob(["#{@root}/**/*.yaml", "#{@root}/**/*.yml"]).each do |yaml|
        parsed_yaml = YAML.parse(File.open(yaml)).root.children
        set_key_list(parsed_yaml, yaml)
      end
    end

    def update_key_list(result_key, current_key, path)
      dict_key = result_key + format_key(current_key.value, result_key)
      location = "#{path[@root.size + 1..-1]}:#{current_key.start_line}"
      @key_list[dict_key].push(location)
    end
  end
end
