# frozen_string_literal: true

class DeleteButtonComponent < ButtonLinkComponent
  def initialize(label:, url:, size: :large, turbo: true, html_attrs: nil)
    super(
      label:,
      url:,
      style: :destructive,
      method: :delete,
      icon: "delete",
      size:,
      turbo:,
      html_attrs:,
    )
  end
end
