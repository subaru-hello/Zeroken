# -*- encoding: utf-8 -*-
# stub: seed-fu 2.3.9 ruby lib

Gem::Specification.new do |s|
  s.name = "seed-fu".freeze
  s.version = "2.3.9"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Michael Bleigh".freeze, "Jon Leighton".freeze]
  s.date = "2018-04-07"
  s.description = "Seed Fu is an attempt to once and for all solve the problem of inserting and maintaining seed data in a database. It uses a variety of techniques gathered from various places around the web and combines them to create what is hopefully the most robust seed data system around.".freeze
  s.email = ["michael@intridea.com".freeze, "j@jonathanleighton.com".freeze]
  s.homepage = "http://github.com/mbleigh/seed-fu".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.0.3".freeze
  s.summary = "Easily manage seed data in your Active Record application".freeze

  s.installed_by_version = "3.0.3" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activerecord>.freeze, [">= 3.1"])
      s.add_runtime_dependency(%q<activesupport>.freeze, [">= 3.1"])
      s.add_development_dependency(%q<rspec>.freeze, ["~> 2.0"])
      s.add_development_dependency(%q<pg>.freeze, ["~> 0"])
      s.add_development_dependency(%q<mysql2>.freeze, ["~> 0"])
      s.add_development_dependency(%q<sqlite3>.freeze, ["~> 0"])
    else
      s.add_dependency(%q<activerecord>.freeze, [">= 3.1"])
      s.add_dependency(%q<activesupport>.freeze, [">= 3.1"])
      s.add_dependency(%q<rspec>.freeze, ["~> 2.0"])
      s.add_dependency(%q<pg>.freeze, ["~> 0"])
      s.add_dependency(%q<mysql2>.freeze, ["~> 0"])
      s.add_dependency(%q<sqlite3>.freeze, ["~> 0"])
    end
  else
    s.add_dependency(%q<activerecord>.freeze, [">= 3.1"])
    s.add_dependency(%q<activesupport>.freeze, [">= 3.1"])
    s.add_dependency(%q<rspec>.freeze, ["~> 2.0"])
    s.add_dependency(%q<pg>.freeze, ["~> 0"])
    s.add_dependency(%q<mysql2>.freeze, ["~> 0"])
    s.add_dependency(%q<sqlite3>.freeze, ["~> 0"])
  end
end
