require 'thor'
require_relative 'generator'

class Commandly::CLI < Thor
  # Reject invalid options
  check_unknown_options!
  # Set exit code of failing command if failure
  def self.exit_on_failure?
    true
  end

  # Set Verbose class option
  class_option 'verbose', :type => :boolean, :default => false

  desc 'version', 'Display version'
  map %w[-v --version] => :version
  def version
    say "commandly v#{Commandly::VERSION}"
  end

  desc 'new PATH', 'Create a new project from template'
  option :android, :type => :boolean, :aliases => '-a'
  option :xcode, :type => :boolean, :aliases => '-x'
  option :template, :aliases => '-t'
  def new(path)
    path = File.expand_path(path)
    raise Error, set_color("ERROR: #{path} already exists.", :red) if File.exist?(path)
    say "Creating project at #{path}"
    say "Creating Android project at #{path}" if options[:android]

    generator = Commandly::Generator.new
    generator.destination_root = path
    generator.invoke_all

    # say options
  end
end
