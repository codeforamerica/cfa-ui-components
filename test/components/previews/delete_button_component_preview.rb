class DeleteButtonComponentPreview < ViewComponent::Preview
  def large
    render(DeleteButtonComponent.new(label: "Delete", url: "/destroy"))
  end

  def small
    render(DeleteButtonComponent.new(label: "Delete", url: "/destroy", size: :small))
  end
end
