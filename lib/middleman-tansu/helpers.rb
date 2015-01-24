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
    end
  end
end
