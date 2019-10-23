# frozen_string_literal: true

module Enumerable
  def my_each
    return to_enum unless block_given?

    arr = to_a
    i = 0
    while i < arr.length
      yield(arr[i])
      i += 1
    end
  end

  def my_each_with_index
    return to_enum unless block_given?

    arr = to_a
    i = 0
    while i < arr.length
      yield(arr[i], i)
      i += 1
    end
  end

  def my_select
    return to_enum unless block_given?

    ret_arr = []
    my_each do |i|
      ret_arr.push(i) if yield(i)
    end

    ret_arr
  end

  def my_all?
    return true unless block_given?

    my_each do |i|
      return false unless yield(i)
    end
    true
  end

  def my_any?
    return true unless block_given?

    my_each do |i|
      return true if yield(i)
    end

    return false
  end

  def my_none?
    return true unless block_given?

    self.my_each do |i|
      return false if yield(i)
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
