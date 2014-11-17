class Post
  include PostsHelper
  include Mongoid::Document
  include Mongoid::Timestamps

  field :user_id, type: Integer # in postgres
  field :tenant_id, type: BSON::ObjectId
  field :title, type: String
  field :body, type: String
  field :published, type: Boolean

  validates :title, :body, presence: true
  validates :title, length: { maximum: 255 }

  def self.search(pattern, title_body)
    regex = Regexp.new(".*#{pattern}.*")
    if pattern
      if title_body
        any_of({title: regex}, {body: regex})
      else
        # We probably want to limit what kind of patterns are allowed --- we
        # don't want a REGEX "injection attack" where a user puts in a tough
        # regex that searches for *everything* (e.g., a letter 'a').
        where(title: regex)
      end
    else
      where(nil)
    end
  end
end
