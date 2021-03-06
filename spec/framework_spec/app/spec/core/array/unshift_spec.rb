require File.dirname(File.join(__rhoGetCurrentDir(), __FILE__)) + '/../../spec_helper'
require File.dirname(File.join(__rhoGetCurrentDir(), __FILE__)) + '/fixtures/classes'

describe "Array#unshift" do
  it "prepends object to the original array" do
    a = [1, 2, 3]
    a.unshift("a").should equal(a)
    a.should == ['a', 1, 2, 3]
    a.unshift().should equal(a)
    a.should == ['a', 1, 2, 3]
    a.unshift(5, 4, 3)
    a.should == [5, 4, 3, 'a', 1, 2, 3]

    # shift all but one element
    a = [1, 2]
    a.shift
    a.unshift(3, 4)
    a.should == [3, 4, 2]

    # now shift all elements
    a.shift
    a.shift
    a.shift
    a.unshift(3, 4)
    a.should == [3, 4]
  end

  it "quietly ignores unshifting nothing" do
    [].unshift().should == []
    [].unshift(*[]).should == []
  end

  it "properly handles recursive arrays" do
    empty = ArraySpecs.empty_recursive_array
    empty.unshift(:new).should == [:new, empty]

    array = ArraySpecs.recursive_array
    array.unshift(:new)
    array[0..5].should == [:new, 1, 'two', 3.0, array, array]
  end

  ruby_version_is "" ... "1.9" do
    it "raises a TypeError on a frozen array" do
      lambda { ArraySpecs.frozen_array.unshift(1) }.should raise_error(TypeError)
    end
  end

  ruby_version_is "1.9" do
    ruby_bug "[ruby-core:23666]", "1.9.2" do
      it "raises a RuntimeError on a frozen array" do
        lambda { ArraySpecs.frozen_array.unshift(1) }.should raise_error(RuntimeError)
        lambda { ArraySpecs.frozen_array.unshift    }.should raise_error(RuntimeError)
      end
    end
  end

  ruby_version_is ""..."1.9" do
    it "does not raise an exception on a frozen array if no modification takes place" do
      ArraySpecs.frozen_array.unshift.should == [1, 2, 3]
    end
  end
end
