def what_was_that_one_with(those_actors)
  # Find the movies starring all `those_actors` (an array of actor names).
  # Show each movie's title and id.

  Movie
    .select(:id, :title)
    .joins(:actors)
    .where(actors: {name: those_actors})
    .group(:id)
    .having('COUNT(actors.id) >= ?', those_actors.length)
end

def golden_age
  # Find the decade with the highest average movie score.
  Movie
    .select('AVG(score) AS average_score, (yr / 10) * 10 AS decade')
    .group('decade')
    .order('average_score DESC')
    .first
    .decade
end

def costars(name)
  # List the names of the actors that the named actor has ever
  # appeared with.
  # Hint: use a subquery

  Actor
    .select(:name).distinct
    .joins(:castings)
    .where(castings: {movie_id: Casting
                                    .select(:movie_id)
                                    .joins(:actor)
                                    .where(actors: {name: name})})
    .where.not(actors: {name: name})
    .pluck(:name)
end

def actor_out_of_work
  # Find the number of actors in the database who have not appeared in a movie
  busy_actors = Casting.select(:actor_id).distinct

  Actor.where.not(id: busy_actors).count
end

def starring(whazzername)
  # Find the movies with an actor who had a name like `whazzername`.
  # A name is like whazzername if the actor's name contains all of the
  # letters in whazzername, ignoring case, in order.

  # ex. "Sylvester Stallone" is like "sylvester" and "lester stone" but
  # not like "stallone sylvester" or "zylvester ztallone"
  name_match = ""

  whazzername.each_char.with_index do |char, idx|
    next if char == " "
    if idx == 0
      name_match << "%" + char + "%"
    else
      name_match << char + "%"
    end
  end

  Movie
    .joins(:actors)
    .where('actors.name ILIKE ?', name_match)
end

def longest_career
  # Find the 3 actors who had the longest careers
  # (the greatest time between first and last movie).
  # Order by actor names. Show each actor's id, name, and the length of
  # their career.

  Actor
    .select('actors.*, (MAX(movies.yr) - MIN(movies.yr)) AS career')
    .joins(:movies)
    .group('actors.id')
    .order('career DESC, name')
    .limit(3)
end