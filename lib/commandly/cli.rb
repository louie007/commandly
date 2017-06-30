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

  desc 'new PROJECT_NAME', 'Create a new project from template'
  option :android, :type => :boolean, :aliases => '-a'
  option :ios, :type => :boolean, :aliases => '-i'
  option :template, :aliases => '-t'
  def new(project_name)
    project_path = File.expand_path(project_name)
    say "Project name #{project_name}"
    raise Error, set_color("ERROR: #{project_path} already exists.", :red) if File.exist?(project_path)

    generator = Commandly::Generator.new
    generator.destination_root = project_path

    if options[:ios]
      say "Creating iOS project at #{project_path}"
      generator.invoke(:copy_ios_templates)
      generator.invoke(:find_replace_ios_text)
      generator.invoke(:rename_ios_files)
    end

    if options[:android]
      say "Creating Android project at #{project_path}"
      generator.invoke(:copy_android_templates)
      generator.invoke(:find_replace_android_text)
      generator.invoke(:rename_android_files)
    end

    if options[:ios].nil? && options[:android].nil?
      say "Creating iOS and Android project at #{project_path}"
      generator.invoke_all
    end
    
    # say options
  end
end
