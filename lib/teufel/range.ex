import Kernel, except: [to_string: 1]

defimpl String.Chars, for: Range do
  def to_string(%Range{first: first, last: last}) do
    "#{first}-#{last}"
  end
end
