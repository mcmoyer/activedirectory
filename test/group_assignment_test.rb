require File.join(File.dirname(File.expand_path(__FILE__)), *%w[helper])

class GroupAssignmentTest < ActiveSupport::TestCase

  @@cn = "CN=#{CONFIG[:test][:samaccountname]},CN=Users,#{CONFIG[:connection][:base]}"
  @@keys = {:mail => CONFIG[:test][:email], 
            :givenname => "tester-first", 
            :sn => "tester-last", 
            :description => "testing login -- delete if seen -- tests should automatically delete this user after running",
            :samaccountname => CONFIG[:test][:samaccountname] }

  def setup 
    @ad_user = ActiveDirectory::User.create(@@cn, @@keys)
    @ad_group1 = ActiveDirectory::Group.create("cn=#{CONFIG[:test][:group_1_name]},OU=web_groups,#{CONFIG[:connection][:base]}",
                                               :name => CONFIG[:test][:group_1_name],
                                               :description => "test group #{CONFIG[:test][:group_1_name]}")

    @ad_group2 = ActiveDirectory::Group.create("cn=#{CONFIG[:test][:group_2_name]},OU=web_groups,#{CONFIG[:connection][:base]}",
                                               :name => CONFIG[:test][:group_2_name],
                                               :description => "test group #{CONFIG[:test][:group_2_name]}")
  end

  def teardown 
    @ad_user.destroy
    @ad_group1.destroy
    @ad_group2.destroy
  end

  test "test entities exist" do
    assert_not_nil @ad_user
    assert_not_nil @ad_group1
    assert_not_nil @ad_group2
  end

  test "user is not assigned to any groups" do
    assert !@ad_group1.has_member?(@ad_user)
  end

  test "user is assigned to one group" do
    @ad_group1.add(@ad_user)
    @ad_user.reload
    @ad_group1.reload
    assert @ad_group1.has_member?(@ad_user)
  end

  test "user is assigned to more than one group" do
    @ad_group1.add(@ad_user)
    @ad_group2.add(@ad_user)
    @ad_group1.reload
    @ad_group2.reload
    @ad_user.reload
    assert @ad_group1.has_member?(@ad_user)
    assert @ad_group2.has_member?(@ad_user)
    assert_equal @ad_user.groups.length, 2
  end
end

