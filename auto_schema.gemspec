$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "auto_schema/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "auto_schema"
  s.version     = AutoSchema::VERSION
  s.authors     = ["bbtfr"]
  s.email       = ["bbtfrr@gmail.com"]
  s.homepage    = "https://github.com/bbtfr/auto_schema"
  s.summary     = "Define database schema in model."
  s.description = "Automatically update the database structure when the code is updated."

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.0.2"

  s.add_development_dependency "sqlite3"
end
