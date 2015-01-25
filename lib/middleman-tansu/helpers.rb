module Middleman
  module Tansu
    module Helpers
      def path_list(current_path)
        paths = []
        splited = current_path.split("/")
        splited.each_with_index do |val, index|
          path = File.join("/", splited[0..index])
          path = path + "/" unless /\.html$/ =~ path
          val  = val.sub(".html", "") if /\.html$/ =~ val
          paths.push({path: path, name: val}) unless /^index$/ =~ val
        end
        paths
      end

      def breadcrumbs(klass = 'breadcrumbs', root = "Top")
        li = []
        li.push("<li class=\"root\">#{link_to(root, "/")}</li>")

        paths = path_list(current_resource.path)
        paths.each do |path|
          if path == paths.last
            li.push("<li class=\"current\">#{path[:name]}</li>")
          else
            li.push("<li>#{link_to(path[:name], path[:path])}</li>")
          end
        end
        "<ul class=\"#{klass}\">\n#{li.join("\n")}\n</ul>"
      end

      def children_pages(key = :date, order_by = :asc)
        dirs  = []
        pages = []

        current_resource.children.each do |page|
          if !exclude?(page.path)
            if /index\.html$/ =~ page.path
              dirs.push(page)
            else
              pages.push(page)
            end
          end
        end

        # Sorting pages and dirs
        if order_by == :desc
          pages = pages.sort {|a, b|
            b.data[key] <=> a.data[key]
          }
          dirs = dirs.sort {|a, b|
            b.path <=> a.path
          }
        else
          pages = pages.sort {|a, b|
            a.data[key] <=> b.data[key]
          }
          dirs = dirs.sort {|a, b|
            a.path <=> b.path
          }
        end

        dirs | pages
      end

      def exclude?(path)
        regex = Regexp.new("^(#{exclude(path).join("|")})")
        regex =~ path
      end

      def exclude(path)
        default = [
          config.images_dir,
          config.js_dir,
          config.css_dir,
          config.layouts_dir,
          config.tansu[:templates_dir]
        ]
        dirs = default | config.tansu[:exclude_path]
      end

      def page_name(page)
        if page.data.title
          paths = page.path.split("/")
          paths.pop
          File.join(paths, page.data.title).gsub(/^\//, "")
        else
          page.path.gsub(/(\/index)?\.html$/, "")
        end
      end

      def page_url(page)
        File.join("/", page.path.gsub(/index\.html$/, ""))
      end
    end
  end
end
