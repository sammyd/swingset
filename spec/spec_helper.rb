# Set up
#-----------------------------------------------------------------------------#

require 'rubygems'
require 'bacon'
require 'pretty_bacon'
require 'pathname'

ROOT = Pathname.new(File.expand_path('../../', __FILE__))

$LOAD_PATH.unshift((ROOT + 'ext').to_s)
$LOAD_PATH.unshift((ROOT + 'lib').to_s)
require 'swingset'

$LOAD_PATH.unshift((ROOT + 'spec').to_s)
