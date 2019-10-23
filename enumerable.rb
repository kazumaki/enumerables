module Enumerable
  def my_each
    return self.to_enum if !block_given?
    range_arr = self.to_a

    i = 0
    while (i < range_arr.length) do
      yield(range_arr[i])
      i += 1
    end  
  end
end
