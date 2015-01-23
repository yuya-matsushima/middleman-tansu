module Middleman
  module Tansu
    class Drawer
      def initialize(app, exclude_path = [])
        @config       = app.config
        @dirs         = ["/"]
        @exclude_path = exclude(exclude_path)
        search_directory(@config.source)
      end

      def empty
        empty     = []
        @dirs.each do |dir|
          glob_path = File.join(@config.source, dir, 'index.html*')
          if Dir.glob(glob_path).length == 0
            empty.push(dir)
          end
        end
        empty
      end

      def search_directory(dir)
        regex = Regexp.new("^" + @config.source)
        Dir.glob(File.join(dir, '*')).each do |path|
          if File.ftype(path) == "directory" && !exclude?(path)
            @dirs.push(path.gsub(regex, ""))
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
          @config.templates_dir
        ]
        default | path
      end

      def exclude?(path)
        regex = Regexp.new("^#{@config.source}/(#{@exclude_path.join("|")})")
        regex =~ path
      end
    end
  end
end
