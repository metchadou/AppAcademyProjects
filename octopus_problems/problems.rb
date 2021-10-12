fish = ['fish', 'fiiish', 'fiiiiish', 'fiiiish', 'fffish', 'ffiiiiisshh', 'fsh', 'fiiiissshhhhhh']

def sluggish_octopus(fish)
  longest_fish = nil

  fish.each do |fs1|
    fish.each do |fs2|
      if fs1.length > fs2.length
        longest_fish = fs1
      else
        longest_fish = fs2
      end
    end
  end

  longest_fish
end

# puts sluggish_octopus(fish)

def dominant_octopus(fish)
  sorted_fish = merge_sort(fish) {|fish1, fish2| fish1.length <=> fish2.length}
  sorted_fish.last
end

def merge_sort (array, &prc)
  return array if array.length <= 1

  mid_idx = array.length / 2
  merge(
    merge_sort(array.take(mid_idx), &prc),
    merge_sort(array.drop(mid_idx), &prc),
    &prc
  )
end

def merge(left, right, &prc)
  merged_array = []
  prc = Proc.new { |num1, num2| num1 <=> num2 } unless block_given?
  until left.empty? || right.empty?
    case prc.call(left.first, right.first)
    when -1
      merged_array << left.shift
    when 0
      merged_array << left.shift
    when 1
      merged_array << right.shift
    end
  end

  merged_array + left + right
end

# puts dominant_octopus(fish)

def clever_octopus(fish)
  longest_fish = ""

  fish.each {|fs| longest_fish = fs if fs.length > longest_fish.length}

  longest_fish
end

# puts clever_octopus(fish)

tiles_array = ["up", "right-up", "right", "right-down", "down", "left-down", "left",  "left-up" ]

def slow_dance(dir, tiles)
  tiles.each_with_index {|tile, i| return i if tile == dir}
  nil
end

# puts slow_dance("up", tiles_array)
# puts slow_dance("right-down", tiles_array)

tiles_hash = {
  "up" => 0,
  "right-up" => 1,
  "right" => 2,
  "right-down" => 3,
  "down" => 4,
  "left_down" => 5,
  "left" => 6,
  "left-up" => 7,
}

def constant_dance(dir, tiles)
  tiles[dir]
end

puts constant_dance("down", tiles_hash)
puts constant_dance("left-up", tiles_hash)