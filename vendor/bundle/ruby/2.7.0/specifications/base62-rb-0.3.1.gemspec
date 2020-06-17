# -*- encoding: utf-8 -*-
# stub: base62-rb 0.3.1 ruby lib

Gem::Specification.new do |s|
  s.name = "base62-rb".freeze
  s.version = "0.3.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Steven Yue".freeze]
  s.date = "2016-09-30"
  s.description = "Fast Base62 encoding and decoding in Ruby".freeze
  s.email = ["jincheker@gmail.com".freeze]
  s.homepage = "https://github.com/steventen/base62-rb".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.1.2".freeze
  s.summary = "Fast Base62 encoding and decoding in Ruby".freeze

  s.installed_by_version = "3.1.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_development_dependency(%q<bundler>.freeze, ["~> 1.7"])
    s.add_development_dependency(%q<rake>.freeze, ["~> 10.0"])
  else
    s.add_dependency(%q<bundler>.freeze, ["~> 1.7"])
    s.add_dependency(%q<rake>.freeze, ["~> 10.0"])
  end
end
