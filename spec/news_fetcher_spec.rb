require 'test_helper'

describe NewsFetcher do
  it 'has a version number' do
    NewsFetcher::VERSION.wont_be_nil
  end

  describe 'strip_extension' do
    subject do
      NewsFetcher.strip_extension('foo.xml')
    end

    it 'strips file extension' do
      subject.must_equal 'foo'
    end
  end
end
