require 'rspec'
require 'projects.rb'

describe "my_uniq" do
  let(:array_1) { [1, 4, 4, 8, 1] }
  let(:array_2) { ["matin", "midi", "matin", "soir"] }

  it "takes an array as argument" do
    expect { my_uniq(array_1) }.to_not raise_error
    expect { my_uniq(array_2) }.to_not raise_error
  end

  it "does not call the built-in method Array#uniq" do
    expect(array_1).to_not receive(:uniq)
    expect(array_2).to_not receive(:uniq)
  end

  it "returns a new array containing no duplicate" do
    expect(my_uniq(array_1)).to eq([1, 4, 8])
    expect(my_uniq(array_2)).to eq(["matin", "midi", "soir"])
  end
end

describe "two_sum" do
  let(:numbers_1) { [-1, 0, 2, -2, 1] }
  let(:numbers_2) { [10, -10, -10, 10] }

  it "takes an array of numbers as argument" do
    expect { two_sum(numbers_1) }.to_not raise_error
    expect { two_sum(numbers_2) }.to_not raise_error
  end

  it "returns an array of pairs of indices of elements that sum to zero" do
    expect(two_sum(numbers_1)).to eq([[0, 4], [2, 3]])
  end

  it "returns pairs sorted 'dictionary-wise'" do
    expect(two_sum(numbers_2)).to eq([[0, 1], [0, 2], [1, 3], [2, 3]])
  end
end

describe "my_transpose" do
  let(:rows1) do
    [ [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8] ]
  end

  let(:rows2) do
    [ ["a", "b", "c"],
      ["d", "e", "f"],
      ["g", "h", "i"] ]
  end

  let(:cols1) do
    [ [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8] ]
  end

  let(:cols2) do
    [ ["a", "d", "g"],
      ["b", "e", "h"],
      ["c", "f", "i"] ]
  end

  it "takes a 2D array as argument" do
    expect { my_transpose(rows1) }.to_not raise_error
    expect { my_transpose(rows2) }.to_not raise_error
  end

  it "return a new 2D array where each row becomes a column and each column becomes a row" do
    expect(my_transpose(rows1)).to eq(cols1)
    expect(my_transpose(rows2)).to eq(cols2)
  end
end

describe "most_profitable_days_pair" do
  let(:prices1) { [10, 7, 7, 8, 10, 9, 11, 10] }
  let(:prices2) { [6, 8, 5, 10, 11, 20, 3, 7] }

  it "takes an array of stock prices as argument" do
    expect { most_profitable_days_pair(prices1) }.to_not raise_error
    expect { most_profitable_days_pair(prices2) }.to_not raise_error
  end

  it "returns the most profitablepair of days on which to buy the stock and then sell it" do
    expect(most_profitable_days_pair(prices1)).to eq([1, 6])
    expect(most_profitable_days_pair(prices2)).to eq([2, 5])
  end
end

describe TowerOfHanoi do
  subject(:game) { TowerOfHanoi.new(3) }

  describe "#move" do
    it "accepts an array of two digits representing pile positions" do
      expect { game.move([1, 2]) }.to_not raise_error
    end

    it "moves discs from source pile to target pile" do
      source_pile = game.piles[0]
      target_pile = game.piles[1]
      game.move([1, 2])

      expect(source_pile.available_space).to eq(1)
      expect(target_pile.available_space).to eq(2)
    end

    it "raises an exception when a given position is invalid" do
      expect { game.move([1, 4]) }.to raise_error("Invalid position")
    end

    it "raises an exception when trying to move big disc on small disc" do
      game.move([1, 2])

      expect { game.move([1, 2]) }.to raise_error("Move not allowed")
    end
  end

  describe "#won?" do
    it "returns true when the last pile is full and the others are empty" do
      game.move([1, 3])
      game.move([1, 2])
      game.move([3, 2])
      game.move([1, 3])
      game.move([2, 1])
      game.move([2, 3])
      game.move([1, 3])

      expect(game.won?).to be(true)
    end
  end

end