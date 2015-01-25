require "middleman-tansu/drawer"
require "middleman-tansu/helpers"

module Middleman
  module Tansu
    class Extension < ::Middleman::Extension
      option :exclude_path, %w(sitemap.xml), "Path list that you don't want to see"
      option :templates_dir, "templates", "Path of template directory's path in source direcotry"
      option :index_template_name, "index.html", "Name of index template"
      option :default_document, "index.html", "Name of default document. When you use IIS, set 'default.html'"

      # Helpers for use within templates and layouts.
      self.defined_helpers = [ ::Middleman::Tansu::Helpers ]

      def initialize(app, options_hash = {}, &block)
        super
        app.config.tansu = {
          :exclude_path     => options[:exclude_path],
          :templates_dir    => options[:templates_dir],
          :default_document => options[:default_document]
        }
      end

      def after_configuration
        exclude_path = options.exclude_path || []
        Drawer.new(app, options, exclude_path).empty.each do |path|
          app.proxy(File.join(path, options[:default_document]),
                    File.join("/", options.templates_dir, options.index_template_name),
                    ignore: true)
        end
      end
    end
  end
end
