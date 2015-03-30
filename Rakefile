begin

  #-----------------------------------------------------------------------------#

  namespace :spec do
    desc 'Run all specs'
    task :all do
      puts "\n\033[0;32mUsing #{`ruby --version`.chomp}\033[0m"
      title 'Running the specs'
      sh "bundle exec bacon #{FileList['spec/**/*_spec.rb'].join(' ')}"

      Rake::Task['rubocop'].invoke
    end

    desc 'Run single spec'
    task :single, :spec_file do |_t, args|
      sh "bundle exec bacon #{args.spec_file}"
    end
  end

  desc 'Run all specs'
  task :spec => 'spec:all'

  task :default => :spec

  #-- RuboCop ----------------------------------------------------------------#

  require 'rubocop/rake_task'
  RuboCop::RakeTask.new(:rubocop) do |task|
    task.patterns = ['lib', 'spec', 'bin']
  end

rescue LoadError, NameError => e
  $stderr.puts "\033[0;31m" \
    '[!] Some Rake tasks haven been disabled because the environment' \
    ' couldn’t be loaded. Be sure to run `rake bootstrap` first.' \
    "\e[0m"
  $stderr.puts e.message
  $stderr.puts e.backtrace
  $stderr.puts
end


# UI Helpers
#-----------------------------------------------------------------------------#

# Prints a title.
#
def title(string)
  puts
  puts yellow(string)
  puts '-' * 80
end

# Prints a subtitle
#
def subtitle(string)
  puts cyan(string)
end

# Colorizes a string to yellow.
#
def yellow(string)
  "\033[0;33m#{string}\e[0m"
end

# Colorizes a string to red.
#
def red(string)
  "\033[0;31m#{string}\e[0m"
end

# Colorizes a string to green.
#
def green(string)
  "\033[0;32m#{string}\e[0m"
end

# Colorizes a string to cyan.
#
def cyan(string)
  "\n\033[0;36m#{string}\033[0m"
end

def confirm(message, decline_by_default=true)
  options = ['y', 'n']
  options[decline_by_default ? 1 : 0].upcase!
  print yellow("#{message}: [#{options.join('/')}] ")
  input = STDIN.gets.chomp
  if input == options[1].downcase || (input == '' && decline_by_default)
    puts red("Aborted by user.")
    exit 1
  end
end
