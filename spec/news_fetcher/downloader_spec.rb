require 'test_helper'

describe NewsFetcher::Downloader do
  describe 'each_zip' do
    before do
      Typhoeus::Expectation.clear

      http_folder = 'http://feed.omgili.com/5Rh5AMTrc4Pv/mainstream/posts/'
      file_path = File.expand_path('spec/fixtures/compressed.zip')
      @file_checksum = Digest::MD5.file(file_path).hexdigest

      local_file = File.expand_path('downloads/1463248613102.zip')
      File.delete(local_file) if File.exist?(local_file)

      html_response = Typhoeus::Response.new(code: 200, body: folder_html)
      Typhoeus.stub(http_folder).and_return(html_response)

      file_response = Typhoeus::Response.new(code: 200, body: File.read(file_path))
      Typhoeus.stub("#{http_folder}1463248613102.zip").and_return(file_response)

      @downloads = []
      NewsFetcher::Downloader.each_zip(http_folder, 1) do |download_path|
        @downloads << download_path
      end
    end

    it 'downloads all files from HTTP folder' do
      @downloads.size.must_equal 1
    end

    it 'doesnt create corrupt file' do
      downloaded_checksum = Digest::MD5.file(@downloads.first).hexdigest
      downloaded_checksum.must_equal @file_checksum
    end
  end

  let(:folder_html) do
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
