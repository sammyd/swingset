require File.expand_path('../spec_helper', __FILE__)

# Tests for SwingSet
#
module SwingSetSpecs
  describe SwingSet::SwingSet do
    describe 'Initialization' do
      it 'should correctly populate the name and platform' do
        name = 'samplename'
        platform = :osx
        swingset = SwingSet::SwingSet.new(name, platform)
        swingset.name.should.equal name
        swingset.platform.should == platform
      end

      it 'should have a default name of SwingSet' do
        swingset = SwingSet::SwingSet.new
        swingset.name.should == 'SwingSet'
      end

      it 'should have a default platform of :ios' do
        swingset = SwingSet::SwingSet.new('name')
        swingset.platform.should == :ios
      end

      it 'should create an empty frameworks array' do
        swingset = SwingSet::SwingSet.new
        swingset.frameworks.should == []
      end
    end

    describe 'adding frameworks' do
      before do
        @swingset = SwingSet::SwingSet.new
      end

      it 'should add the path to the frameworks array' do
        @swingset.add_framework('/tmp')
        @swingset.frameworks.should == ['/tmp']
      end

      it 'should only add the framework if it exists on disc' do
        @swingset.add_framework('/this/path/should/really/never/exist')
        @swingset.frameworks.should == []
      end
    end
  end
end
