# A ViewComponent preview (not Lookbook::Preview) so it is served at
# /rails/view_components/form_example/default and can be driven by system tests
# (e.g. the form-reset specs).
class FormExamplePreview < FormComponentPreview
  def default
    render_with_template
  end
end
