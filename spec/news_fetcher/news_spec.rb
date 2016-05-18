require 'test_helper'

describe NewsFetcher::News do
  describe 'id=' do
    subject do
      news = NewsFetcher::News.new
      news.id = 'foo.xml'
      news
    end

    it 'strips file extension' do
      subject.id.must_equal 'foo'
    end
  end
end
