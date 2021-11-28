class ShortenedUrl < ApplicationRecord
  validates :short_url, presence: true, uniqueness: true
  validates :long_url, presence: true
  validate :no_spamming, :nonpremium_max

  belongs_to :submitter, {
    class_name: :User,
    foreign_key: :user_id,
    primary_key: :id
  }

  has_many :visits, {
    class_name: :Visit,
    foreign_key: :short_url_id,
    primary_key: :id,
    dependent: :destroy
  }

  has_many :visitors, 
    -> { distinct }, {
    through: :visits,
    source: :visitor
  }

  has_many :taggings, {
    class_name: :Tagging,
    foreign_key: :short_url_id,
    primary_key: :id,
    dependent: :destroy
  }

  has_many :tag_topics, {
    through: :taggings,
    source: :tag_topic
  }

  def self.random_code
    loop
      code = SecureRandom.urlsafe_base64
      return code unless ShortenedUrl.exists?(:short_url => code)
    end
  end

  def self.create_short_url_for_user(user, long_url)
    ShortenedUrl.create!({
      long_url: long_url,
      short_url: ShortenedUrl.random_code,
      user_id: user.id
    })
  end

  def num_clicks
    self.visits.count
  end

  def num_uniques
    self.visitors.count
  end

  def num_recent_uniques
    visits.select('user_id')
          .where('created_at > ?', 10.minutes.ago)
          .distinct
          .count
  end

  def self.prune(n)
    #select ids of all visited urls
    visited_urls_ids = Visit.all.map{|vst| vst.short_url_id}.uniq

    #select ids of urls that have been visited but haven't been in the last n minutes
    visited_urls_ids_in_last_n_minutes = Visit.where('created_at >= ?', n.minutes.ago).map{|vst| vst.short_url_id}.uniq
    urls_ids_not_visited_in_last_n_minutes = visited_urls_ids - visited_urls_ids_in_last_n_minutes

    #select ids of urls that have never been visited and are older than n minutes
    unvisited_old_urls = ShortenedUrl.all.select do |url|
      !visited_urls_ids.include?(url.id) && url.created_at < n.minutes.ago
    end.map{|url| url.id}

    #delete urls
    to_delete = urls_ids_not_visited_in_last_n_minutes + unvisited_old_urls

    to_delete.uniq.each do |id|
      url = ShortenedUrl.find_by(id: id)
      url.destroy unless url.submitter.premium
    end
  end

  private

  def no_spamming
    recently_submitted_urls = ShortenedUrl.all.where('created_at >= ?', 1.minute.ago)
    recent_submitters_ids = recently_submitted_urls.map {|url| url.user_id}

    if recent_submitters_ids.count(user_id) >= 5
      errors[:user] << 'cannot submit more than 5 urls in a minute'
    end
  end

  def nonpremium_max
    submits_count = ShortenedUrl.where(user_id: user_id).length

    if !submitter.premium && submits_count >= 5
      errors[:nonpremium] << 'users can submit up to five urls'
    end
  end

end