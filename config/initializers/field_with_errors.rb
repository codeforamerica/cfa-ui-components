puts "disabling .field_with_errors wrappers (in lookbook app)" unless Rails.env.test?
ActionView::Base.field_error_proc = proc do |html_tag, instance|
  html_tag.html_safe
end
