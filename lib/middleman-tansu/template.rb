require 'middleman-core/templates'

module Middleman
  module Tansu
    # Template class of Middleman
    class Template < Middleman::Templates::Base
      class_option 'css_dir',
        default: 'stylesheets',
        desc: 'The path to the css files'
      class_option 'js_dir',
        default: 'javascripts',
        desc: 'The path to the javascript files'
      class_option 'images_dir',
        default: 'images',
        desc: 'The path to the image files'

      def self.source_root
        File.join(File.dirname(__FILE__), 'template')
      end

      def build_scaffold!
        template 'shared/Gemfile.tt', File.join(location, 'Gemfile')
        template 'shared/config.tt', File.join(location, 'config.rb')

        empty_directory File.join(location, 'source', options[:css_dir])
        empty_directory File.join(location, 'source', options[:js_dir])
        empty_directory File.join(location, 'source', options[:images_dir])
        empty_directory File.join(location, 'source', 'templates')
        empty_directory File.join(location, 'source', 'layouts')

        copy_file 'source/sample.html.md', File.join(location, 'source/sample.html.md')
        copy_file 'source/sitemap.xml.builder', File.join(location, 'source/sitemap.xml.builder')
        copy_file 'source/layouts/layout.slim', File.join(location, 'source/layouts/layout.slim')
        copy_file 'source/templates/index.html.slim', File.join(location, 'source/templates/index.html.slim')
        copy_file 'source/stylesheets/all.css.sass', File.join(location, 'source', options[:css_dir], 'all.css.sass')
        copy_file 'source/stylesheets/_gemoji.sass', File.join(location, 'source', options[:css_dir], '_gemoji.sass')
        copy_file 'source/stylesheets/pure-min.css', File.join(location, 'source', options[:css_dir], 'pure-min.css')
        copy_file 'source/stylesheets/github-markdown.css', File.join(location, 'source', options[:css_dir], 'github-markdown.css')
      end
    end
  end
end
