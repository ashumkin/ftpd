require File.expand_path('spec_helper', File.dirname(__FILE__))

describe SymlinkHelper do

  include SymlinkHelper

  context 'when symlink is supported' do
    specify do
      expect(symlink_supported?).to be true
    end
  end

  context 'when symlink is not supported' do
    specify do
      allow(File).to receive(:symlink).and_raise(NotImplementedError)
      expect(symlink_supported?).to be false
    end
  end

  context 'when called as a module function' do
    specify do
      SymlinkHelper.symlink_supported?
    end
  end

end
