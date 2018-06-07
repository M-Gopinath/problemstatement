module UserCommentHelper
  def sanitize_description(desc)
    sanitize desc, :tags => %w(b i)
  end
end
