class PreviewController < ViewComponentsController
  around_action :switch_locale

  def switch_locale(&action)
    I18n.with_locale(display_lang || I18n.default_locale, &action)
  end

  # Lookbook bundles all preview display options into a single URL-encoded JSON
  # `_display` query param (e.g. ?_display=%7B%22lang%22%3A%22es%22%7D). We defer
  # to Lookbook's own SearchParamParser to decode it so we track the gem's
  # encoding rather than re-deriving it by hand. The rescue covers malformed
  # input and the chance that this internal service is renamed in a future
  # release — either way we fall back to the default locale.
  def display_lang
    raw = params[:_display]
    return if raw.blank?

    Lookbook::SearchParamParser.call(raw)[:lang].presence
  rescue
    nil
  end
end
