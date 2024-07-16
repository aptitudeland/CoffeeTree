require "test_helper"

class AccessoryTest < ActiveSupport::TestCase
  test "valid accessory should be saved" do
    accessory = Accessory.new(name: 'test accessory', grinder_min: 0, accessory_type: "Grinder", grinder_max: 30, user: User.first)
    assert accessory.save
  end
  test "accessory should have a name" do
    accessory = Accessory.new(grinder_min: 0, accessory_type: "Grinder", grinder_max: 30, user: User.first)
    assert_not accessory.save
  end
  test "accessory should have a accessory type" do
    accessory = Accessory.new(name: "test accessory", grinder_min: 0, grinder_max: 30, user: User.first)
    assert_not accessory.save
  end
  test "accessory should have an accessory type included in valid accessory types" do
    accessory = Accessory.new(name: "test accessory", grinder_min: 0, accessory_type: "test", grinder_max: 30, user: User.first)
    assert_not accessory.save
  end
  test "accessory should have a grinder_min" do
    accessory = Accessory.new(name: "test accessory", accessory_type: "Grinder", grinder_max: 30, user: User.first)
    assert_not accessory.save
  end
  test "accessory should have a grinder_max" do
    accessory = Accessory.new(name: "test accessory", grinder_min: 0, accessory_type: "Grinder", user: User.first)
    assert_not accessory.save
  end
  test "accessory should have a grinder_min smaller or aqual to grinder_max" do
    accessory = Accessory.new(name:"test_name", grinder_min: 10, accessory_type: "Grinder", grinder_max: 5, user: User.first)
    assert_not accessory.save
  end
end
