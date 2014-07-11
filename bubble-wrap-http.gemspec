# -*- encoding: utf-8 -*-
Gem::Specification.new do |spec|
  version = '1.7.0' # sync'd to BW version
  spec.name          = "bubble-wrap-http"
  spec.version       = version
  spec.authors       = ['Matt Aimonetti', 'Francis Chong', 'James Harton', 'Clay Allsopp', 'Dylan Markow', 'Jan Weinkauff', 'Marin Usalj']
  spec.email         = ['mattaimonetti@gmail.com', 'francis@ignition.hk', 'james@sociable.co.nz', 'clay.allsopp@gmail.com', 'dylan@dylanmarkow.com', 'jan@dreimannzelt.de', 'mneorr@gmail.com']
  spec.description   = "BubbleWrap's deprecated HTTP library"
  spec.summary       = "BubbleWrap's deprecated HTTP library"
  spec.homepage      = "https://github.com/rubymotion/BubbleWrap-HTTP"
  spec.license       = "MIT"

  files = []
  files << 'README.md'
  files.concat(Dir.glob('lib/**/*.rb'))
  files.concat(Dir.glob('motion/**/*.rb'))
  spec.files         = files
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "rake"
end
