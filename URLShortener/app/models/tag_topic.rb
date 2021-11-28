class TagTopic < ApplicationRecord
  has_many :taggings, {
    class_name: :Tagging,
    foreign_key: :tag_topic_id,
    primary_key: :id
  }

  has_many :urls, {
    through: :taggings,
    source: :url
  }

  def popular_links
    links_with_num_clicks = {}
    links_sorted_by_popularity = self.urls.sort_by {|url| url.num_clicks}.last(5)
    
    links_sorted_by_popularity.each {|link| links_with_num_clicks[link.short_url] = link.num_clicks}

    links_with_num_clicks
  end
end