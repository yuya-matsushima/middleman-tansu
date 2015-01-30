require "middleman-core/cli"
require "active_support/core_ext/time/zones"

module Middleman
  module Cli
    # This class provides a "tansu" command for the middleman CLI.
    # "tansu" command has some options:
    # - '-f': set file extension, default "md"
    # - '-d': set date(yyyy-mm-dd). Default is now. This is used in Frontmatter.
    # - '-a': set author name. Default "ENV['USER']".
    # - '-z': set timezone.
    # - '--frontmatter': add data to Frontmatter
    class Tansu < Thor
      include Thor::Actions

      check_unknown_options!

      namespace :tansu

      def initialize(*args)
        super
        Time.zone = ENV['TZ'] || "UTC"
      end

      def self.source_root
        ENV['MM_ROOT']
      end

      # Tell Thor to exit with a nonzero exit code on failure
      def self.exit_on_failure?
        true
      end

      desc "tansu path/to/TITLE", "Create a new Tansu page"
      method_option "file",
        aliases: "-f",
        desc: "The file extension of file (default: md)",
        default: "md"
      method_option "timezone",
        aliases: "-z",
        desc: "The timezone of Frontmatter (default: ENV['TZ'])"
      method_option "date",
        aliases: "-d",
        desc: "The date of Frontmatter (default: Time.zone.now)",
        default: nil
      method_option "author",
        aliases: "-a",
        desc: "The author name of Frontmatter (default: ENV['USER'])"
      method_option "frontmatter",
        desc: "Additions of Frontmatter. ex: \"category: sample, tags: frontmatter\"",
        default: ""
      def tansu(path)
        paths     = path.split("/")
        title     = paths.pop
        ext       = options[:file]
        Time.zone = options[:timezone] || ENV['TZ'] || "UTC"
        date      = options[:date] ? Time.zone.parse(options[:date]) : Time.zone.now
        author    = options[:author] || ENV["USER"]
        add_frontmatter = options[:frontmatter]

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
          f.puts frontmatter(title, author, date, add_frontmatter)
        end
        puts "create new tansu page: #{file}"
      end

      no_tasks do
        def frontmatter(title, author, date, frontmatter)
          data = {
            :title  => title,
            :author => author,
            :date   => date
          }

          if !frontmatter.empty?
            data = data.merge(add_frontmatter(frontmatter))
          end

          rows = ["---"]
          data.each do |label, data|
            rows << "#{label}: #{data.to_s.strip}"
          end
          rows << ["---"]
          rows << "\n\n"

          rows.join("\n")
        end

        def add_frontmatter(str)
          {} if str.empty?

          frontmatter = {}
          str.split(",").each do |row|
            if /.+:.+/ =~ row
              ary, label, data = row.split(/(.+?):(.+)$/)
              frontmatter[label] = data
            else
              frontmatter[row] = ""
            end
          end
          frontmatter
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
