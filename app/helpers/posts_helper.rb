module PostsHelper
  def date_posted
    self.created_at.to_formatted_s(:my_format)
  end
end
