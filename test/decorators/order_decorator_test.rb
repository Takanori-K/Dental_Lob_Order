# frozen_string_literal: true

require 'test_helper'

class OrderDecoratorTest < ActiveSupport::TestCase
  def setup
    @order = Order.new.extend OrderDecorator
  end

  # test "the truth" do
  #   assert true
  # end
end
