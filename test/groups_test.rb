require File.join(File.dirname(File.expand_path(__FILE__)), *%w[helper])

class GroupTest < ActiveSupport::TestCase

  test "find a group" do
    ad = ActiveDirectory::Group.find(:first)
    assert !ad.nil?
  end

  test "creation of groups" do
    ActiveDirectory::Group.create("cn=#{CONFIG[:test][:group_1_name]},OU=web_groups,#{CONFIG[:connection][:base]}",
                                  :name => CONFIG[:test][:group_1_name],
                                  :description => "this is a test group",
                                  :info => "this is where the info is stored")
    group = ActiveDirectory::Group.find(:first, :filter => {:name => CONFIG[:test][:group_1_name]})
    assert_not_nil group
    assert_equal group.name, CONFIG[:test][:group_1_name]
    group.destroy

    group = ActiveDirectory::Group.find(:first, :filter => {:name => CONFIG[:test][:group_1_name]})
    assert_nil group

  end
end

