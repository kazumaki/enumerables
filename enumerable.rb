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

  def my_map *proc_obj
    return self.to_enum if !block_given? && proc_obj.empty?
    ret_arr = []
    if(!proc_obj.empty?)
      self.my_each { |i| ret_arr.push(proc_obj[0].call(i)) }
    else
      self.my_each { |i| ret_arr.push(yield(i)) }
    end

    return ret_arr
  end

  def my_inject *x
    if(x.empty?)
      ret_val = self.first
      self.my_each_with_index do |val, i|
        if i > 0
          ret_val = yield(ret_val, val)
        end
      end
    else
      ret_val = x[0]
      self.my_each { |i| ret_val = yield(ret_val, i) }
    end

    return ret_val
  end
end

def multiply_els arr
  return arr.my_inject{ |result, value| result * value }
end

a_proc = Proc.new do |i|
  2
end

arr = (1..10).my_map
puts arr

puts multiply_els([2,4,5])




