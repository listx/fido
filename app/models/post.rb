class Post < ActiveRecord::Base
  include PostsHelper
  belongs_to :user

  validates :title, :body, presence: true
  validates :title, length: { maximum: 255 }
  has_objectid_columns

  def self.search(search, title_body)
    if search
      if title_body
        where('title LIKE ? OR body LIKE ?', "%#{search}%", "%#{search}%")
      else
        where('title LIKE ?', "%#{search}%")
      end
    else
      where(nil)
    end
  end
end
