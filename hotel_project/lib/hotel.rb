require_relative "room"

class Hotel
  def initialize(name, capacities)
    @name = name
    @rooms = {}
    capacities.each do |room, capacity|
      @rooms[room] = Room.new(capacity)
    end
  end

  def name
    @name.split.map(&:capitalize).join(" ")
  end

  def rooms
    @rooms
  end

  def room_exists?(room)
    @rooms.has_key?(room)
  end

  def check_in(person, room)
    if self.room_exists?(room)
      if @rooms[room].add_occupant(person)
        puts "check in successful"
      else
        puts "sorry, room is full"
      end
    else
      puts "sorry, room does not exist"
    end
  end

  def has_vacancy?
    @rooms.values.any? { |room| room.available_space > 0 }
  end

  def list_rooms
    @rooms.each do |room_name, room_instance|
      puts "#{room_name} : #{room_instance.available_space}"
    end
  end

end