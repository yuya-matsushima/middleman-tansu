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
    end
  end
end
