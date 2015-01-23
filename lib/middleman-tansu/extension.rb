require "middleman-tansu/drawer"

module Middleman
  module Tansu
    class Extension < ::Middleman::Extension
      option :index_template_name, "index.html", "Name of index template"

      def initialize(app, options_hash = {}, &block)
        super
      end

      def after_configuration
        exclude_path = app.config.exclude_path || []
        Drawer.new(app, exclude_path).empty.each do |path|
          app.proxy(File.join(path, "index.html"),
                    File.join("/", app.config.templates_dir, options.index_template_name),
                    ignore: true)
        end
      end
    end
  end
end
