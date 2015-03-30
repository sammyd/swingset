require 'rubygems'
require 'bundler/setup'

# require your gems as usual
require 'xcodeproj'
require 'xcplayground'

# Create a new project
proj = Xcodeproj::Project.new("~/Desktop/FrameworkProvider.xcodeproj")

# Add a new aggregate target
# Target
target = proj.new(Xcodeproj::Project::Object::PBXAggregateTarget)
proj.targets << target
target.name = "FrameworkProvider"
target.product_name = "FrameworkProvider"
target.build_configuration_list = Xcodeproj::Project::ProjectHelper.configuration_list(proj, :osx, nil, nil, :swift)

# Create a "copy files" build phase, and add it
copy_files = target.new_copy_files_build_phase()

# Configure the output location of build files
copy_files.symbol_dst_subfolder_spec = :products_directory

target.pretty_print

# Add the relevant files to the project and to the copy files build phase

f1 = proj.new_file("/Users/sam/dev/temp/dl/Carthage/Build/Mac/Argo.framework")
f2 = proj.new_file("/Users/sam/dev/temp/dl/Carthage/Build/Mac/Runes.framework")

copy_files.add_file_reference(f1)
copy_files.add_file_reference(f2)

# Save the project
proj.save

# Create a new workspace with new project
ws = Xcodeproj::Workspace.new([])

ws << proj.path

# Create a playground
playground = Xcplayground::Playground.new('~/Desktop/WithFrameworks.playground', :osx)
playground.save

# Add the playground to the workspace
ws << playground.path

# Save the workspace
ws.save_as("/Users/sam/Desktop/PlaygroundWithFrameworks.xcworkspace")


