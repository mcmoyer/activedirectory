unless Config::CONFIG["ruby_version"] == '1.8'
  require 'psych'
end
require 'rake/testtask'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name        = "active_directory"
    gem.summary     = "An interface library for accessing Microsoft's Active Directory."
    gem.description = "ActiveDirectory uses Net::LDAP to provide a means of accessing and modifying an Active Directory data store.  This is a fork of the activedirectory gem."
    gem.author      = "Adam T Kerr - Marlon Moyer"
    gem.email       = "ajrkerr@gmail.com;marlon@mcmoyer.com"
    gem.homepage    = "http://github.com/mcmoyer/activedirectory"
    
    # gem.files        = FileList["lib/**/*.rb"]
    # gem.require_path = "lib"
    gem.add_dependency 'net-ldap', '>= 0.1.1'
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList['test/*_test.rb']
  t.verbose = true
end
