# frozen_string_literal: true

module FFaker
  module Metal
    extend ModuleUtils

    module_function

    def theme
      fetch_sample(themes)
    end

    def group
      "#{fetch_sample(groups['first'])} #{fetch_sample(groups['second'])}"
    end

    def release
      group
    end

    def themes
      @themes ||= YAML.load_file(Rails.root.join("data/development/themes.yml"))
    end

    def groups
      @groups ||= YAML.load_file(Rails.root.join("data/development/groups.yml"))
    end
  end
end
