module Middleman
  module Tansu
    # This class provides a "tansu" command for the middleman CLI.
    class Tansu < Thor
      include Thor::Actions

      check_unknown_options!

      namespace :tansu

      def self.source_root
        ENV['MM_ROOT']
      end

      # Tell Thor to exit with a nonzero exit code on failure
      def self.exit_on_failure?
        true
      end

      desc "tansu path/to/TITLE", "Create a new Tansu page with markdown"
      def tansu(path)
        paths = path.split("/")
        title = paths.pop

        if /\.html\.md$/ !~ title
          filename = title + '.html.md'
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
          f.puts frontmatter(title)
        end
        puts "create new article: #{file}"
      end

      no_tasks do
        def frontmatter(title)
          rows = []
          rows << "---"
          rows << "title: #{title}"
          rows << "author: #{ENV['USER']}"
          rows << "date: #{Time.now}"
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
