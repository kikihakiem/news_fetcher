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
      Typhoeus::Expectation.clear

      file_path = File.expand_path('spec/fixtures/compressed.zip')

      local_file = File.expand_path('downloads/1463248613102.zip')
      File.delete(local_file) if File.exist?(local_file)

      html_response = Typhoeus::Response.new(code: 200, body: http_folder)
      Typhoeus.stub(feed_url).and_return(html_response)

      file_response = Typhoeus::Response.new(code: 200, body: File.read(file_path))
      Typhoeus.stub("#{feed_url}1463248613102.zip").and_return(file_response)
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

    let(:http_folder) do
      %q[<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
        <html>
         <head>
          <title>Index of /5Rh5AMTrc4Pv/mainstream/posts</title>
         </head>
         <body>
        <h1>Index of /5Rh5AMTrc4Pv/mainstream/posts</h1>
        <table><tr><th><a href="?C=N;O=D">Name</a></th><th><a href="?C=M;O=A">Last modified</a></th><th><a href="?C=S;O=A">Size</a></th><th><a href="?C=D;O=A">Description</a></th></tr><tr><th colspan="4"><hr></th></tr>
        <tr><td><a href="/5Rh5AMTrc4Pv/mainstream/">Parent Directory</a></td><td>&nbsp;</td><td align="right">  - </td><td>&nbsp;</td></tr>
        <tr><td><a href="1463248613102.zip">1463248613102.zip</a></td><td align="right">14-May-2016 21:03  </td><td align="right">9.9M</td><td>&nbsp;</td></tr>
        <tr><th colspan="4"><hr></th></tr>
        </table>
        </body></html>
      ]
    end
  end
end
