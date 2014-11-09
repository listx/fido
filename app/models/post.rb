class Post < ActiveRecord::Base
  include PostsHelper
  belongs_to :user

  validates :title, :body, presence: true
  validates :title, length: { maximum: 255 }

  def self.search(search)
    if search
      where('title LIKE ?', "%#{search}%")
    else
      where(nil)
    end
  end
end
