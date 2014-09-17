module ApplicationHelper
  def full_title(title)
    base_title = "Twitter"
    if title.empty?
      return base_title
    end
    "#{base_title}|#{title}"
  end
end
