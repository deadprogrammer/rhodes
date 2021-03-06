require File.dirname(File.join(__rhoGetCurrentDir(), __FILE__)) + '/../../spec_helper'
require File.dirname(File.join(__rhoGetCurrentDir(), __FILE__)) + '/fixtures/classes'

describe "Enumerable#group_by" do
  ruby_version_is "1.8.7" do
    it "returns a hash with values grouped according to the block" do
      EnumerableSpecs::Numerous.new(*%w(foo bar baz)).group_by{ |word| word[0..0].to_sym }.
        should == { :f => ["foo"], :b => ["bar", "baz"]}
    end

    it "returns an empty hash for empty enumerables" do
      EnumerableSpecs::Empty.new.group_by { |x| x}.should == {}
    end
  
    it "returns an Enumerator if called without a block" do
      EnumerableSpecs::Numerous.new.group_by.should be_kind_of(enumerator_class)
    end
  end
end