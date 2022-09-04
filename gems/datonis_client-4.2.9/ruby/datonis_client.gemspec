$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "datonis/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'datonis_client'
  s.version     =  Datonis::VERSION
  s.date        = '2014-09-03'
  s.summary     = "A gem that allows you to access apis on the datonis platform"
  s.description = "A gem that allows you to access apis on the datonis platform"
  s.authors     = ["Atul Gore"]
  s.email       = 'atul@altizon.com'
  s.files       = Dir["{app,config,db,lib}/**/*"]
  s.homepage    = 'https://github.com/Altizon/datonis_client'    
  s.license     = 'Apache License, Version 2.0'
  s.add_development_dependency "rake" 
  s.add_development_dependency "activesupport"
  s.add_development_dependency "rspec" 
  s.add_development_dependency "webmock" 
  s.add_development_dependency "simplecov" 
end
