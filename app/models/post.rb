class Post < ActiveRecord::Base
  include PostsHelper
  belongs_to :user

  validates :title, :body, presence: true
  validates :title, length: { maximum: 255 }
end
