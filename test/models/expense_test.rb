require 'test_helper'

# class ExpenseTest < ActiveSupport::TestCase
class ExpenseTest < MiniTest::Test

    test "the truth" do
     assert false
   end

  test "fail new expense without datas" do
    expense = Expense.new
    assert_not expense.save
  end
end
