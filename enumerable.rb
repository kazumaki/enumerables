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

  def my_select
    return self.to_enum if !block_given?

    ret_arr = []
    self.my_each do |i|
      if(yield(i))
        ret_arr.push(i)
      end
    end
    return ret_arr
  end

  def my_all?
    return true if !block_given?

    self.my_each do |i|
      if(!yield(i))
        return false
      end
    end
    return true
  end

  def my_any?
    return true if !block_given?

    self.my_each do |i|
      if(yield(i))
        return true
      end
    end
    return false
  end

  def my_none?
    return true if !block_given?

    self.my_each do |i|
      if(yield(i))
        return false
      end
    end
    return true
  end

  def my_count *x
    count = 0
    if x.empty?
      self.my_each { |i| count += 1 } if !block_given?
      self.my_each { |i| count += 1 if yield(i) } if block_given?
    else
      self.my_each { |i| count += 1 if i == x[0] }
    end
    return count
  end

  def my_map
    return self.to_enum if !block_given?

    ret_arr = []

    self.my_each { |i| ret_arr.push(yield(i)) }

    return ret_arr
  end

end

count = (1..10).my_map { |x| 2 }

puts count

