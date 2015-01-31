module Middleman
  module Tansu
    # Drawer search empty(index.html.* isn't exist) directory
    # in app.config.source
    #
    # example:
    # ary = Drawer.new(app, options, exclude_path).empty
    class Drawer
      def initialize(app, options, exclude_path = [])
        @config       = app.config
        @options      = options
        @dirs         = ['/']
        @exclude_path = exclude(exclude_path)
      end

      def empty
        search_directory(@config.source)
        empty = []
        @dirs.each do |dir|
          glob_path = File.join(@config.source, dir,
                                "#{@config.tansu[:default_document].strip}*")
          empty.push(dir) if Dir.glob(glob_path).length == 0
        end
        empty
      end

      def search_directory(dir)
        regex = Regexp.new('^' + @config.source)
        Dir.glob(File.join(dir, '*')).each do |path|
          if File.ftype(path) == 'directory' && !exclude?(path)
            @dirs.push(path.gsub(regex, ''))
            search_directory(path)
          end
        end
      end

      def exclude(path)
        default = [
          @config.images_dir,
          @config.js_dir,
          @config.css_dir,
          @config.layouts_dir,
          @options.templates_dir
        ]
        default | path
      end

      def exclude?(path)
        regex = Regexp.new("^#{@config.source}/(#{@exclude_path.join('|')})")
        regex =~ path
      end
    end
  end
end
