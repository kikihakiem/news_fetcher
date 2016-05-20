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

  describe 'save_to_redis' do
    let(:md5_hash) { '123' }
    let(:xml) { '<xml>foo</xml>' }

    subject do
      redis = Redis.current
      redis.lrange('NEWS_XML', 0, -1)
    end

    describe 'when news is not already in redis' do
      before do
        NewsFetcher.save_to_redis(md5_hash, xml)
      end

      it 'adds to NEWS_XML redis list' do
        subject.size.must_equal 1
        subject.first.must_equal xml
      end
    end

    describe 'when news is already in redis' do
      before do
        NewsFetcher.save_to_redis(md5_hash, xml)
        NewsFetcher.save_to_redis(md5_hash, '<xml>bar</xml>')
      end

      it 'doesnt create duplicate data' do
        subject.size.must_equal 1
        subject.first.must_equal xml
      end
    end
  end

  describe 'each_news' do
    before do
      stub_http_client(feed_url)
    end

    let(:feed_url) { 'http://feed.com/xml/' }

    subject do
      results = []
      NewsFetcher.each_news(feed_url) do |md5_hash, xml|
        results << {md5_hash: md5_hash, xml: xml}
      end

      results
    end

    it 'yields md5_hash and its content' do
      subject.first[:md5_hash].must_equal 'file1'
      subject.first[:xml].must_equal 'file1 content'
      subject.last[:md5_hash].must_equal 'file2'
      subject.last[:xml].must_equal 'content of file2'
    end
  end
end
