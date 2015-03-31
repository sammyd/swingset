#
module SwingSet
  # The primary class for swingset, representing the completed project
  class SwingSet
    require 'xcplayground'
    require 'fileutils'

    attr_reader :name
    attr_reader :platform
    attr_reader :frameworks

    def initialize(name = 'SwingSet', platform = :ios)
      @name = name
      @platform = platform
      @frameworks = []
    end

    def add_framework(path)
      @frameworks << path if Dir.exist?(path)
    end

    def write_swingset(path)
      epath = File.expand_path(path)
      FileUtils.mkdir_p(epath)
      proj_path = write_project(epath, platform)
      pg_path   = write_playground(epath, platform, name)
      write_workspace(epath, name, [proj_path, pg_path])
    end

    private

    def write_project(path, platform)
      framework_provider = FrameworkProvider.new(path, platform)
      frameworks.each { |f| framework_provider.add_framework(f) }
      framework_provider.write
      framework_provider.path
    end

    def write_playground(path, platform, name)
      pg_path = File.join(path, name + '.playground')
      pg = Xcplayground::Playground.new(pg_path, platform)
      pg.save
      pg.path
    end

    def write_workspace(path, name, contents)
      ws = Xcodeproj::Workspace.new([])
      contents.each { |c| ws << c }
      ws.save_as(File.join(path, name + '.xcworkspace'))
    end
  end
end
