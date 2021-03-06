$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'autotask_rest_api/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'autotask_rest_api'
  s.version     = AutotaskRestApi::VERSION
  s.authors     = ['Talha Ijaz']
  s.email       = ['talhaijaz123451@gmail.com']
  s.homepage    = 'https://github.com/MSPCFO/autotask_rest_api'
  s.summary     = 'Autotask API wrapper'
  s.description = 'Abstracted Autotask API 1.5 wrapper'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']

  s.add_dependency 'nokogiri', '>= 1', '< 2'
  s.add_dependency 'rest-client'
end
