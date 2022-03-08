class Post < ApplicationRecord
  validates :title, presence: {message: "is required"}
  validates :subs, presence: {message: ": at least one sub is required"}
  
  belongs_to :author,
    class_name: :User

  has_many :post_subs,
    dependent: :destroy,
    inverse_of: :post

  has_many :subs,
    through: :post_subs,
    source: :sub

  has_many :comments,
    dependent: :destroy

  has_many :votes,
    :as => :votable,
    dependent: :destroy

  def total_upvotes
    self.votes.where(value: 1).count
  end

  def total_downvotes
    self.votes.where(value: -1).count
  end

  def top_level_comments
    self.comments.where(parent_comment_id: nil)
  end

  def comments_by_parent_id
    comments_grouped_by_parent_id = Hash.new {|h, k| h[k] = []}

    self.comments.each do |comment|
      comments_grouped_by_parent_id[comment.parent_comment_id] << comment
    end

    comments_grouped_by_parent_id
  end


end
