require File.join(File.dirname(File.expand_path(__FILE__)), *%w[helper])

class UserTest < ActiveSupport::TestCase

  test "find a user" do
    ad = ActiveDirectory::User.find(:first)
    assert !ad.nil?
  end

  test "creating a user" do
    cn = "CN=#{CONFIG[:test][:samaccountname]},CN=Users,#{CONFIG[:connection][:base]}"
    keys = {:mail => CONFIG[:test][:email], 
            :givenname => "tester-first", 
            :sn => "tester-last", 
            :description => "testing login -- delete if seen -- tests should automatically delete this user after running",
            :samaccountname => CONFIG[:test][:samaccountname]}
    ad_user = ActiveDirectory::User.create(cn,keys)
    assert_not_nil ad_user
    assert_equal ad_user.givenname, "tester-first"
    assert ad_user.disabled?
    ad_user.change_password("a1b2c3d4e5")
    ad_user.reload
    assert !ad_user.disabled?
    assert ad_user.destroy
  end

end

