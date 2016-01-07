Gem::Specification.new do |s|
  s.name          = 'scripted_client'
  s.version       = '0.1.1'
  s.date          = '2015-07-18'
  s.summary       = 'A client to consume the Scripted.com API'
  s.description   = 'Provides a simple wrapper for creating, listing and reviewing Scripted.com Jobs and Pitches.'
  s.authors       = ['Jake Kring']
  s.email         = 'jake@scripted.com'
  s.files         = Dir["{lib}/**/*.rb", "bin/*", "LICENSE", "*.md"]
  s.homepage      = 'http://rubygems.org/gems/scripted_client'
  s.license       = 'MIT'
  s.require_paths = ['lib']
  s.add_runtime_dependency 'activeresource', '~> 4'
  s.add_development_dependency 'rspec', '= 3.3.0'
end
