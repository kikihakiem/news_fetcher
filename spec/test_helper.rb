$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'news_fetcher'

require 'minitest/autorun'
require 'minitest/spec'

require 'byebug'
require 'fakeredis/minitest'

class Minitest::Spec
  def stub_http_client(feed_url)
    Typhoeus::Expectation.clear
    http_folder = %q[<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
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

    file_path = File.expand_path('spec/fixtures/compressed.zip')

    local_file = File.expand_path('downloads/1463248613102.zip')
    File.delete(local_file) if File.exist?(local_file)

    html_response = Typhoeus::Response.new(code: 200, body: http_folder)
    Typhoeus.stub(feed_url).and_return(html_response)

    file_response = Typhoeus::Response.new(code: 200, body: File.read(file_path))
    Typhoeus.stub("#{feed_url}1463248613102.zip").and_return(file_response)
  end
end
