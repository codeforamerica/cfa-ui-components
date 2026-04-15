# Use a span instead of Rails' default div to avoid breaking inline layouts
puts "using span for .field_with_errors wrapper (in lookbook app)" unless Rails.env.test?
ActionView::Base.field_error_proc = proc do |html_tag, _instance|
  %(<span class="field_with_errors">#{html_tag}</span>).html_safe
end
