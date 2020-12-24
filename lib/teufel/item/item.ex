defprotocol Teufel.Item do
  @spec to_display(t()) :: list(tuple())
  def to_display(item)
end
