# frozen_string_literal: true

class AlertComponent < BaseComponent
  # One-off small outline button scoped to the alert; the shared ButtonComponent
  # has no equivalent size/variant yet. Renders a link when `url:` is given,
  # otherwise a plain `type="button"` the caller can wire up via html attrs.
  ACTION_CLASSES = "cfa-alert__action inline-flex h-8 items-center justify-center whitespace-nowrap rounded " \
    "border border-border-default bg-transparent px-cfa-med text-sm font-medium leading-none text-button-secondary-text " \
    "no-underline cursor-pointer hover:bg-primary-hover active:bg-primary-pressed " \
    "focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-focus"

  renders_many :actions, ->(label:, url: nil, **html_attrs) do
    html_attrs = html_attrs.merge(class: class_names(ACTION_CLASSES, html_attrs[:class]))
    if url
      link_to(label, url, **html_attrs)
    else
      content_tag(:button, label, type: "button", **html_attrs)
    end
  end

  DISMISSIBLE_VALUES = [false, true, :session].freeze

  # copy_scope: an i18n scope holding the alert's copy. With it, a dismissal is
  # remembered in a cookie named after a digest of that copy in English, so new
  # copy shows the alert again but switching language doesn't.
  def initialize(variant: :info, title: nil, dismissible: false, copy_scope: nil, css_class: nil)
    raise ArgumentError, "dismissible must be one of #{DISMISSIBLE_VALUES}" unless DISMISSIBLE_VALUES.include?(dismissible)
    raise ArgumentError, "dismissible: :session needs a copy_scope" if dismissible == :session && copy_scope.nil?

    @title = title
    @dismissible = dismissible
    @copy_scope = copy_scope
    @css_class = css_class

    @icon_name =
      case variant
      when :info then :info_outline
      when :warning then :warning_outline
      else raise ArgumentError.new("Invalid alert variant")
      end
  end

  attr_reader :title, :dismissible, :copy_scope, :icon_name

  def render?
    !persists_dismissal? || request.cookies[dismissal_cookie_name].blank?
  end

  # Without a title, a single line of text lines up with the actions.
  def center_content?
    title.blank? && actions?
  end

  def persists_dismissal?
    dismissible.present? && copy_scope.present?
  end

  def dismissal_cookie_name
    @dismissal_cookie_name ||= begin
      english_copy = I18n.t(copy_scope, locale: :en, raise: true)
      digest = Digest::SHA256.hexdigest(english_copy.to_json).first(12)
      "alert_dismissed_#{copy_scope.split(".").last}_#{digest}"
    end
  end

  # Without max-age, the browser drops the cookie when the session ends.
  def dismissal_cookie
    attributes = ["#{dismissal_cookie_name}=1", "path=/", "SameSite=Lax"]
    attributes << "max-age=#{1.year.to_i}" if dismissible == true
    attributes << "Secure" if request.ssl?
    attributes.join("; ")
  end
end
