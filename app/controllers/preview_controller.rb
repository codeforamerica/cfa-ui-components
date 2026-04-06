class PreviewController < ViewComponentsController
  around_action :switch_locale

  def switch_locale(&action)
    locale = params.dig(:lookbook, :display, :lang) || I18n.default_locale
    I18n.with_locale(locale, &action)
  end
end
