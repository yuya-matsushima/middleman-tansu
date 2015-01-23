require "middleman-core/cli"
require "active_support/core_ext/time/zones"

module Middleman
  module Cli
    # This class provides a "tansu" command for the middleman CLI.
    class Tansu < Thor
      include Thor::Actions

      check_unknown_options!

      namespace :tansu

      def initialize(*args)
        super
        Time.zone = Time.zone || "UTC"
      end

      def self.source_root
        ENV['MM_ROOT']
      end

      # Tell Thor to exit with a nonzero exit code on failure
      def self.exit_on_failure?
        true
      end

      desc "tansu path/to/TITLE", "Create a new Tansu page with markdown"
      method_option "file",
        aliases: "-f",
        desc: "The file extension to create the Tansu page",
        default: "md"
      method_option "date",
        aliases: "-d",
        desc: "The date to create the Tansu page with (defaults to now)"
      def tansu(path)
        paths = path.split("/")
        title = paths.pop
        ext   = options[:file]
        date  = options[:date] ? Time.zone.parse(options[:date]) : Time.zone.now

        if Regexp.new(".html.#{ext}$") !~ title
          filename = "#{title}.html.#{ext}"
        end

        dir  = destination_dir(paths)
        file = File.join(dir, filename)

        if !Dir.exists?(dir)
          FileUtils.mkdir_p dir
        end

        if File.exists?(file)
          puts "#{file} is exist"
          exit
        end

        File.open(file, 'w') do |f|
          f.puts frontmatter(title, date)
        end
        puts "create new tansu page: #{file}"
      end

      no_tasks do
        def frontmatter(title, date)
          rows = []
          rows << "---"
          rows << "title: #{title}"
          rows << "author: #{ENV['USER']}"
          rows << "date: #{date}"
          rows << "---"
          rows << "\n\n"

          rows.join("\n")
        end

        def destination_dir(dir)
          app    = Middleman::Application
          source = File.join(app.root, app.config.source)

          if dir == nil || dir == '.'
            source
          else
            File.join(source, dir)
          end
        end
      end
    end
  end
end
