class LoadingComponentPreview < ViewComponent::Preview
  def default
    render(LoadingComponent.new)
  end
end
