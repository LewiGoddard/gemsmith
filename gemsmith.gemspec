$LOAD_PATH.push File.expand_path("../lib", __FILE__)
require "gemsmith/version"

Gem::Specification.new do |spec|
  spec.name = "gemsmith"
  spec.version = Gemsmith::VERSION
  spec.platform = Gem::Platform::RUBY
  spec.authors = ["Brooke Kuhlmann"]
  spec.email = ["brooke@redalchemist.com"]
  spec.homepage = "https://github.com/bkuhlmann/gemsmith"
  spec.summary = "Ruby gem skeleton generation for the professional gemsmith."
  spec.description = "Ruby gem skeleton generation for the professional gemsmith. Includes custom settings, binary, Ruby on Rails, and RSpec support. "
  spec.license = "MIT"

  unless ENV["CI"] == "true"
    spec.signing_key = File.expand_path("~/.ssh/gem-private.pem")
    spec.cert_chain = [File.expand_path("~/.ssh/gem-public.pem")]
  end

  case Gem.ruby_engine
    when "ruby"
      spec.add_development_dependency "pry-byebug"
      spec.add_development_dependency "pry-stack_explorer"
    when "jruby"
      spec.add_development_dependency "pry-nav"
    when "rbx"
      spec.add_development_dependency "pry-nav"
      spec.add_development_dependency "pry-stack_explorer"
    else
      raise RuntimeError.new("Unsupported Ruby Engine!")
  end

  spec.add_dependency "thor", "~> 0.19"
  spec.add_dependency "thor_plus", "~> 1.6"
  spec.add_dependency "rails", "~> 4.1"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "pry-remote"
  spec.add_development_dependency "pry-rescue"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rb-fsevent" # Guard file events for OSX.
  spec.add_development_dependency "guard-rspec"
  spec.add_development_dependency "terminal-notifier-guard"
  spec.add_development_dependency "codeclimate-test-reporter"

  spec.files = Dir["lib/**/{*,.*}"]
  spec.extra_rdoc_files = Dir["README*", "LICENSE*"]
  spec.executables << "gemsmith"
  spec.require_paths = ["lib"]
end
