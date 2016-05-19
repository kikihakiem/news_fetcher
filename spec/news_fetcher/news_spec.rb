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

  describe 'to_json' do
    subject do
      news = NewsFetcher::News.new
      news.forum_title = 'Interesting Things'
      news.external_links = ['http://site1.com', 'http://site2.com']
      news.to_json
    end

    it 'converts to JSON string' do
      subject.must_equal '{"forum_title":"Interesting Things","external_links":["http://site1.com","http://site2.com"]}'
    end
  end
end
