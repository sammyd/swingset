require File.expand_path('../spec_helper', __FILE__)

# Tests for Command
#
module CommandSpecs
  describe SwingSet::Command do
    describe 'the go command' do
      it 'should return the correct string' do
        SwingSet::Command.go.should == 'Hello from swingset'
      end
    end
  end
end
