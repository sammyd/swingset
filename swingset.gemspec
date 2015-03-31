require File.expand_path('../lib/swingset/gem_version', __FILE__)

Gem::Specification.new do |s|
  s.name          = 'swingset'
  s.version       = SwingSet::VERSION
  s.summary       = 'Create Xcode playgrounds with access to precompiled frameworks'
  s.description   = %(
    swingset allows you to test out dynamic frameworks for OS X and iOS >8 using
    Xcode playgrounds. This gem will create the playground, and the necessary
    workspace and project structure to allow importing the frameworks.
  ).strip.gsub(/\s+/, ' ')
  s.authors       = ['Sam Davies']
  s.email         = 'sam@visualputty.co.uk'
  s.files         = %w{ README.md LICENSE } + Dir["lib/**/*.rb"]
  s.homepage      = 'https://github.com/sammyd/swingset'
  s.license       = 'MIT'
  s.executables   = %{swingset}
  s.require_paths = %{lib}

  s.add_runtime_dependency 'xcodeproj', '~> 0.23.1'
  s.add_runtime_dependency 'thor', '~> 0.19.1'
end
