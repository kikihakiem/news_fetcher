require 'test_helper'

describe NewsFetcher::News do
  describe 'hash=' do
    subject do
      news = NewsFetcher::News.new
      news.hash = 'foo.xml'
      news
    end

    it 'strips file extension' do
      subject.hash.must_equal 'foo'
    end
  end
end
