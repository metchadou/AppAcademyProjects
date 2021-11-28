namespace :url_shortener do
  desc "Destroy non-premium and old urls"
  task :destroy_urls, [:minutes] => :environment do
    minutes = args[:minutes].to_i || 10
    puts "Destoring old urls..."
    ShortenedUrl.prune(minutes)
  end
end