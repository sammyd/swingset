#
module SwingSet
  # Represents the "FrameworkProvider" Xcode project
  class FrameworkProvider
    require 'xcodeproj'

    def initialize(path, platform, name = 'FrameworkProvider.xcodeproj')
      @project, @copy_files = prepare_project(path, name, platform)
    end

    def add_framework(path)
      file_ref = @project.new_file(File.expand_path(path))
      @copy_files.add_file_reference(file_ref)
    end

    def write
      @project.save
    end

    def path
      @project.path
    end

    private

    def prepare_project(path, name, platform)
      project = Xcodeproj::Project.new(File.join(path, name))
      target = create_target(project, platform)
      project.targets << target
      copy_files = create_copy_files(target)
      [project, copy_files]
    end

    def create_target(project, platform)
      target = project.new(Xcodeproj::Project::Object::PBXAggregateTarget)
      target.name = 'FrameworkProvider'
      target.product_name = 'FrameworkProvider'
      target.build_configuration_list = Xcodeproj::Project::ProjectHelper
        .configuration_list(project, platform, nil, nil, :swift)
      target
    end

    def create_copy_files(target)
      copy_files = target.new_copy_files_build_phase
      copy_files.symbol_dst_subfolder_spec = :products_directory
      copy_files
    end
  end
end
