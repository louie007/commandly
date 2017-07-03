require 'thor'
require 'git'
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
  option :templateURL, :aliases => '-t'
  def new(project_name)
    project_path = File.expand_path(project_name)
    raise Error, set_color("ERROR: #{project_path} already exists.", :red) if File.exist?(project_path)

    generator = Commandly::Generator.new
    generator.destination_root = project_path
    remote = false

    if options[:templateURL]
      remote = true
      say "Git cloning from git repository: #{options[:templateURL]}"
      Git.clone(options[:templateURL], project_path)
      # Remove .git directory
      `rm -rf #{project_path}/.git`
    end

    if options[:ios]
      say "Creating iOS project at #{project_path}"
      generator.invoke(:copy_ios_templates) unless remote
      generator.invoke(:find_replace_ios_text)
      generator.invoke(:rename_ios_files)
      `rm -rf #{project_path}/android` unless options[:android]
    end

    if options[:android]
      say "Creating Android project at #{project_path}"
      generator.invoke(:copy_android_templates) unless remote
      generator.invoke(:find_replace_android_text)
      generator.invoke(:rename_android_files)
      `rm -rf #{project_path}/ios` unless options[:ios]
    end

    if options[:ios].nil? && options[:android].nil?
      say "Creating iOS and Android project at #{project_path}"
      generator.invoke(:copy_ios_templates) unless remote
      generator.invoke(:find_replace_ios_text)
      generator.invoke(:rename_ios_files)
      generator.invoke(:copy_android_templates) unless remote
      generator.invoke(:find_replace_android_text)
      generator.invoke(:rename_android_files)
    end
  end

end
