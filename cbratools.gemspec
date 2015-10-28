# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = 'cbratools'
  spec.version       = '0.1.0'
  spec.authors       = ['Stephan Hagemann']
  spec.email         = ['stephan.hagemann@gmail.com']
  spec.summary       = %q{cbratools}
  spec.description   = %q{A set of tools to help with refactorings in component-based Rails applications.}
  spec.homepage      = 'https://github.com/shageman/cbratools'
  spec.license       = 'MIT'

  spec.files = Dir["{lib}/**/*", "Rakefile", "README.md"]

  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.5'
  spec.add_development_dependency 'rspec', '~> 2.14', '>= 2.14.1'
end
