class Comment < ApplicationRecord
  validates :content, :author_id, :post_id, presence: true

  belongs_to :author,
    class_name: :User

  belongs_to :post

  belongs_to :parent_comment,
    class_name: :Comment,
    foreign_key: :parent_comment_id,
    optional: true

  has_many :child_comments,
    class_name: :Comment,
    foreign_key: :parent_comment_id

  has_many :votes,
    :as => :votable,
    dependent: :destroy

  def total_upvotes
    self.votes.where(value: 1).count
  end

  def total_downvotes
    self.votes.where(value: -1).count
  end
end
