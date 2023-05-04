# frozen_string_literal: true

require_relative 'test_helper'
require_relative '../lib/stack'

class StackTest < Minitest::Test
  def setup
    @stack = Stack.new
  end
  # BEGIN
  def test_push_should_add_new_item
    assert { @stack.empty? }
    @stack.push!(1)
    assert { @stack.size.positive? }
    assert { @stack.to_a.last == 1 }
    @stack.push!(2)
    assert { @stack.to_a.last == 2 }
  end

  def test_pop_should_delete_last_added_item
    @stack.push!(1)
    @stack.push!(2)
    assert { @stack.size == 2 }
    assert { @stack.to_a.last == 2 }
    @stack.pop!
    assert { @stack.size == 1 }
    assert { @stack.to_a.last == 1 }
  end

  def test_clear_should_clear_stack
    @stack.push!(1)
    @stack.push!(2)
    @stack.push!(3)
    @stack.clear!
    assert { @stack.empty? }
  end

  def test_empty_should_respond_true_if_stack_is_empty
    assert { @stack.empty? == true }
  end
  # END
end

test_methods = StackTest.new({}).methods.select { |method| method.start_with? 'test_' }
raise 'StackTest has not tests!' if test_methods.empty?
