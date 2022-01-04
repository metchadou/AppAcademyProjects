# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

ActiveRecord::Base.transaction do
  users = User.create(
    [{username: "kym"},
     {username: "keke"}]
  )

  artworks = Artwork.create(
    [{title: "Da Vinci", image_url: "www.artworks.com/images/da_vinci_img",artist_id: users.first.id},
     {title: "San graal", image_url: "www.artworks.com/images/san_graal_img", artist_id: users.last.id}]
  )

  ArtworkShare.create(
    [{viewer_id: users.last.id, artwork_id: artworks.first.id},
     {viewer_id: users.first.id, artwork_id: artworks.last.id}]
  )

  Comment.create(
    [
      {body: "good job!", author_id: users.last.id, artwork_id: artworks.first.id},
      {body: "Wow excellent!", author_id: users.first.id, artwork_id: artworks.last.id}
    ]
  )
end