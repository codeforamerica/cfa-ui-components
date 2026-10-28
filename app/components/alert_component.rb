# frozen_string_literal: true

class AlertComponent < BaseComponent
  # One-off small outline button scoped to the alert; the shared ButtonComponent
  # has no equivalent size/variant yet. Renders a link when `url:` is given,
  # otherwise a plain `type="button"` the caller can wire up via html attrs.
  ACTION_CLASSES = "cfa-alert__action inline-flex h-8 items-center justify-center whitespace-nowrap rounded " \
    "border border-border-default bg-transparent px-cfa-med text-sm font-medium leading-none text-text-default " \
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

  def initialize(variant: :info, title: nil, dismissible: false, css_class: nil)
    @title = title
    @dismissible = dismissible
    @css_class = css_class

    @icon_name =
      case variant
      when :info then :info_circle
      when :warning then :warning_outline
      else raise ArgumentError.new("Invalid alert variant")
      end
  end

  attr_reader :title, :dismissible, :icon_name
end
