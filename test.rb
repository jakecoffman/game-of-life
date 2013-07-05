require 'test/unit'
require_relative 'web'

class TestGameOfLife < Test::Unit::TestCase

  def setup
    # Do nothing
  end

  def teardown
    # Do nothing
  end

  def test_under_population
    assert_equal(0, result([
         [0,1,0],
         [0,1,0],
         [0,0,0]
     ], 1, 1, 3))
    assert_equal(0, result([
         [0,0,0],
         [0,1,0],
         [0,0,1]
     ], 1, 1, 3))
    assert_equal(0, result([
         [0,0,0],
         [0,1,0],
         [0,0,0]
     ], 1, 1, 3))
  end

  def test_live_on
    assert_equal(1, result([
         [0,1,0],
         [1,1,0],
         [0,0,0]
     ], 1, 1, 3))
    assert_equal(1, result([
         [0,1,0],
         [1,1,1],
         [0,0,0]
     ], 1, 1, 3))
    assert_equal(1, result([
         [0,1,1],
         [1,1,0],
         [0,0,0]
     ], 1, 1, 3))
  end

  def test_overcrowding
    assert_equal(0, result([
         [0,1,0],
         [1,1,1],
         [0,1,0]
     ], 1, 1, 3))
    assert_equal(0, result([
         [1,0,0],
         [1,1,0],
         [0,1,1]
     ], 1, 1, 3))
  end

  def test_reproduction
    assert_equal(1, result([
       [0,1,0],
       [1,0,0],
       [0,1,0]
     ], 1, 1, 3))
    assert_equal(1, result([
       [1,0,0],
       [1,0,0],
       [0,1,0]
     ], 1, 1, 3))
  end

  def test_tick
    game = [
        [0,1,0],
        [0,1,0],
        [0,1,0]
    ]
    expected = [
        [0,0,0],
        [1,1,1],
        [0,0,0]
    ]
    result = tick game, 3
    assert_equal expected, result
  end

end