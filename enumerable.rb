module Enumerable
  def my_each
    return self.to_enum if !block_given?

    arr = self.to_a
    i = 0
    while (i < arr.length) do
      yield(arr[i])
      i += 1
    end  
  end

  def my_each_with_index
    return self.to_enum if !block_given?

    arr = self.to_a
    i = 0
    while (i < arr.length) do
      yield(arr[i], i)
      i += 1
    end
  end
end

puts (1..10).my_each_with_index do |x, i|
  puts x.to_s + ' ' + i.to_s
end
