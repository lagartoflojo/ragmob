require "spec_helper"

describe Ragmob do
  describe '::VERSION' do
    it 'has a version number' do
      _(Ragmob::VERSION).wont_be_nil
    end
  end
end
