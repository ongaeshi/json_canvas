# frozen_string_literal: true

require_relative "lib/json_canvas/version"

Gem::Specification.new do |spec|
  spec.name = "json_canvas"
  spec.version = JsonCanvas::VERSION
  spec.authors = ["ongaeshi"]
  spec.email = ["ongaeshi0621@gmail.com"]

  spec.summary = "JSONCanvas Implementation for Ruby."
  spec.description = "JsonCanvas is a Ruby gem that provides a robust implementation of the JSONCanvas specification. This gem enables developers to easily create and manipulate JSONCanvas format. It supports functionalities such as adding text, files, links, and grouping nodes with customizable attributes like position, size, and identifiers. Additional features include connecting nodes with edges that have customizable attributes, and the ability to save and load canvas states from JSON files. This gem facilitates the easy integration of the JSONCanvas format into Ruby applications, enhancing development efficiency and user experience."
  spec.homepage = "https://github.com/ongaeshi/json_canvas"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  # spec.metadata["allowed_push_host"] = ""

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/ongaeshi/json_canvas"
  spec.metadata["changelog_uri"] = "https://github.com/ongaeshi/json_canvas/blob/master/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) || f.start_with?(*%w[bin/ test/ spec/ features/ .git .circleci appveyor])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
