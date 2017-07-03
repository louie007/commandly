require 'thor'
require 'thor/group'

class Commandly::Generator < Thor::Group
  include Thor::Actions
  desc 'Generate a new project filesystem structure'

  def self.source_root
    File.dirname(__FILE__) + '/../../templates'
  end

  def copy_ios_templates
    directory "ios", "ios"
  end

  def find_replace_ios_text
    project_name = File.basename(destination_root)
    files = Dir.glob(destination_root + "/ios/**/**")
    files.each do |name|
      next if Dir.exists? name
      text = File.read(name)
      text = text.gsub("Commandly", project_name)
      File.open(name, "w") { |file| file.puts text }
    end
  end

  def rename_ios_files
    project_name = File.basename(destination_root)
    if Dir.exist? destination_root + "/ios/Commandly.xcodeproj"
      File.rename(destination_root + "/ios/Commandly.xcodeproj", destination_root + "/ios/" + project_name + ".xcodeproj")
    end
    if Dir.exist? destination_root + "/ios/Commandly"
      File.rename(destination_root + "/ios/Commandly", destination_root + "/ios/" + project_name)
    end
    if Dir.exist? destination_root + "/ios/CommandlyTests"
      File.rename(destination_root + "/ios/CommandlyTests/CommandlyTests.m", destination_root + "/ios/CommandlyTests/" + project_name + "Tests.m")
      File.rename(destination_root + "/ios/CommandlyTests", destination_root + "/ios/" + project_name + "Tests")
    end
    if Dir.exist? destination_root + "/ios/CommandlyUITests"
      File.rename(destination_root + "/ios/CommandlyUITests/CommandlyUITests.m", "/ios/CommandlyTests/" + project_name + "UITests.m")
      File.rename(destination_root + "/ios/CommandlyUITests", destination_root + "/ios/" + project_name + "UITests")
    end
  end

  def copy_android_templates
    directory "android", "android"
  end

  def find_replace_android_text
    project_name = File.basename(destination_root)
    files = Dir.glob(destination_root + "/android/**/**")
    files -= Dir.glob(destination_root + "/android/**/**/gradle-wrapper.jar")
    files -= Dir.glob(destination_root + "/android/**/**/*.png")
    files.each do |name|
      next if Dir.exists? name
      puts name
      text = File.read(name)
      text = text.gsub("Commandly", project_name)
      text = text.gsub("commandly", project_name.downcase)
      File.open(name, "w") { |file| file.puts text }
    end
  end

  def rename_android_files
    project_name = File.basename(destination_root)
    if Dir.exist? destination_root + "/android/app/src/androidTest/java/com/vuebly/commandly"
      File.rename(destination_root + "/android/app/src/androidTest/java/com/vuebly/commandly", destination_root + "/android/app/src/androidTest/java/com/vuebly/" + project_name.downcase)
    end
    if Dir.exist? destination_root + "/android/app/src/main/java/com/vuebly/commandly"
      File.rename(destination_root + "/android/app/src/main/java/com/vuebly/commandly", destination_root + "/android/app/src/main/java/com/vuebly/" + project_name.downcase)
    end
    if Dir.exist? destination_root + "/android/app/src/test/java/com/vuebly/commandly"
      File.rename(destination_root + "/android/app/src/test/java/com/vuebly/commandly", destination_root + "/android/app/src/test/java/com/vuebly/" + project_name.downcase)
    end
  end
end
