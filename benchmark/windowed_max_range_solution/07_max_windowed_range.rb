require 'benchmark'
require_relative "06_min_max_stack_queue"
require_relative "01_naive"

# O(n) Optimized solution
def max_windowed_range(array, window_size)
  queue = MinMaxStackQueue.new
  best_range = nil

  array.each_with_index do |el, i|
    queue.enqueue(el)
    queue.dequeue if queue.size > window_size

    if queue.size == window_size
      current_range = queue.max - queue.min
      best_range = current_range if !best_range || current_range > best_range
    end
  end

  best_range
end

def max_windowed_range_performance_tests(size)
  arr = Array.new(size) { rand(size * 100) }

  Benchmark.bm(25) do |x|
    x.report("max_windowed_range") {max_windowed_range(arr, 4)}
    x.report("naive_max_windowed_range:") {naive_max_windowed_range(arr, 4)}
  end
end

max_windowed_range_performance_tests(100000)

# if __FILE__ == $PROGRAM_NAME
#   p max_windowed_range(arr, 3) # 4, 8
#   # p max_windowed_range([1, 0, 2, 5, 4, 8], 3) == 5 # 0, 2, 5
#   # p max_windowed_range([1, 0, 2, 5, 4, 8], 4) == 6 # 2, 5, 4, 8
#   # p max_windowed_range([1, 3, 2, 5, 4, 8], 5) == 6 # 3, 2, 5, 4, 8
# end
