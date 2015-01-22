require "middleman-core"
require "middleman-tansu/version"
require "middleman-tansu/command"

::Middleman::Extensions.register(:tansu) do
  require "middleman-tansu/extension"
  ::Middleman::Tansu::Extension
end
