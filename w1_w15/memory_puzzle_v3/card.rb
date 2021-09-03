class Card
  attr_reader :value, :face_up
  def initialize(value)
    @value = value
    @face_up = false
  end

  def display
    if @face_up
      @value
    else
      " "
    end
  end

  def reveal
    @face_up = true
  end

  def hide
    @face_up = false
  end

  def ==(other_card)
    self.to_s == other_card.to_s
  end

  def to_s
    @value.to_s
  end

  def is_bomb?
    @value == "*"
  end
end