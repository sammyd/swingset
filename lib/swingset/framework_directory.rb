#
module SwingSet
  # Will add frameworks to a given swingset
  class FrameworkDirectory
    def initialize(swingset, framework_path)
      @swingset = swingset
      add_frameworks_from_path(path)
    end

    def self.carthage_frameworks(swingset, platform = :ios)
      path = File.join('Carthage', 'Build')
      if platform == :ios
        path = File.join(path, 'iOS')
      elsif platform == :osx
        path = File.join(path, 'Mac')
      else
        return
      end
      FrameworkDirectory.new(swingset, path)
    end

    def add_framework_path(path)
      add_frameworks_from_path(path) if Dir.exist?(path)
    end

    private

    def add_frameworks_from_path(path)
      fw_glob = File.join(path, '*.framework')
      Dir.glob(fw_glob).each do |framework|
        @swingset.add_framework(framework)
      end
    end
  end