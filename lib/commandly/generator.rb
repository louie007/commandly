require 'thor'
require 'thor/group'

class Commandly::Generator < Thor::Group
  include Thor::Actions
  desc 'Generate a new project filesystem structure'

  def self.source_root
    File.dirname(__FILE__) + '/../../templates'
  end

end
