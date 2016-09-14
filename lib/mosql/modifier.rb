module MoSQL
  class Modifier
    def initialize(opts)
      @local_modifiers_path = opts
    end

    def apply_modifier(modifier, ns, column_config, result)
      require "#{@local_modifiers_path}/#{modifier}/modify"
      modify(ns, column_config, result)
    end

    def process(ns, column_config, value)
      return value unless column_config[:modify].is_a? Array && column_config[:modify].length > 0

      column_config[:modify].inject(value) {|result, modifier| apply_modifier(modifier, ns, column_config, result)}
    end
  end
end
