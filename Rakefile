require 'rubygems'
require 'rake/gempackagetask'
require 'rake/rdoctask'

desc 'Build Gem and Packages for Rubyforge'
task :default => [ :repackage ]

spec = Gem::Specification.new do |gem|
	gem.name     = "activedirectory"
	gem.version  = "1.0.2"
	gem.date     = "2008-12-01"
	gem.summary  = "An interface library for accessing Microsoft's Active Directory."
	gem.description = "ActiveDirectory uses Net::LDAP to provide a means of accessing and modifying an Active Directory data store."

	gem.specification_version = 2 if gem.respond_to? :specification_version=

	gem.platform = Gem::Platform::RUBY
	gem.author   = "James R Hunt"
	gem.email    = "james@niftylogic.net"
	gem.homepage = "http://gems.niftylogic.net/activedirectory"
	gem.rubyforge_project = "activedirectory"

	gem.files        = FileList["lib/**/*.rb"]
	gem.require_path = "lib"
	gem.has_rdoc     = true

	gem.add_dependency "net-ldap", "~> 0.1.1"
end

Rake::GemPackageTask.new(spec) do |pkg|
	pkg.gem_spec = spec
	pkg.need_tar = false # Generate a tarball everytime we build
end

Rake::RDocTask.new do |rdoc|
	rdoc.main = "README"
	rdoc.rdoc_files.include("README", "lib/**/*.rb")
end
