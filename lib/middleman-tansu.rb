require "middleman-core"
require "middleman-tansu/version"
require "middleman-tansu/template"
require "middleman-tansu/command"

Middleman::Templates.register :tansu, Middleman::Tansu::Template

::Middleman::Extensions.register(:tansu) do
  require "middleman-tansu/extension"
  ::Middleman::Tansu::Extension
end

