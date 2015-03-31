#
module SwingSet
  require 'thor'
  # Represents the CLI associated with swingset
  #
  class Command < Thor
    option :path
    option :framework_path
    option :name
    desc 'create [PLATFORM]', 'create a new swingset for platform (ios, osx)'
    def create(platform)
      name = options[:name] || 'SwingSet'
      swingset = SwingSet.new(name, platform.to_sym)
      import_frameworks(swingset, options[:framework_path], platform.to_sym)
      write_swingset(swingset, options[:path])
    end

    private

    def import_frameworks(swingset, framework_path, platform)
      if framework_path
        puts 'Importing frameworks from provided directory'
        FrameworkDirectory.new(swingset, framework_path)
      elsif Dir.exist?('Carthage')
        puts 'Importing frameworks from Carthage'
        FrameworkDirectory.carthage_frameworks(swingset, platform)
      else
        puts 'You either need to provide a framework_path or use with Carthage'
        return
      end
    end

    def write_swingset(swingset, path)
      path ||= File.join(Dir.pwd, 'swingset')
      puts 'Writing swingset'
      swingset.write_swingset(path)
    end
  end
end
