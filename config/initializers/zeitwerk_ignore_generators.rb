# Copied from https://github.com/rails/rails/issues/38671#issuecomment-2460201789
puts "Telling Zeitwerk to ignore our generators, as they don't follow the conventional mapping from path to fully-qualified class name (in lookbook app)"
Rails.autoloaders.main.ignore(File.expand_path("../../lib/generators", __dir__))
