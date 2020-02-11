require 'test_helper'

class ChildTest < ActiveSupport::TestCase
  # TODO: Relationship macros
  should have_many(:chores)
  should have_many(:tasks).through(:chores)
  
  # TODO: Validation macros
  should validate_presence_of(:first_name)
  should validate_presence_of(:last_name)

  # TODO: Context testing
  context "Creating a child context" do
    setup do
      create_children
    end
 
    teardown do
      destroy_children
    end
 
    should "have name methods that list first_ and last_names combined" do
      assert_equal "Alex Heimann", @alex.name
      assert_equal "Mark Heimann", @mark.name
      assert_equal "Rachel Heimann", @rachel.name
    end
 
    should "have a scope to alphabetize children" do
      assert_equal ["Alex", "Mark", "Rachel"], Child.alphabetical.map{|c| c.first_name}
    end
 
    should "have a scope to select only active children" do
      assert_equal ["Alex", "Mark"], Child.active.alphabetical.map{|c| c.first_name}
    end

    should "have a points_earned method to see how many points did one child earn" do
      create_tasks
      create_chores
      assert_equal 4, @alex.points_earned
      destroy_chores
      destroy_tasks
    end
  end

end
