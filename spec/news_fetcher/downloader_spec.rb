require 'test_helper'

describe NewsFetcher::Downloader do
  describe 'each_zip' do
    before do
      stub_http_client(http_folder)
    end

    let(:http_folder) { 'http://feed.omgili.com/5Rh5AMTrc4Pv/mainstream/posts/' }
    let(:file_path) { File.expand_path('spec/fixtures/compressed.zip') }
    let(:file_checksum) { Digest::MD5.file(file_path).hexdigest }

    subject do
      downloads = []
      NewsFetcher::Downloader.each_zip(http_folder, 1) do |download_path|
        downloads << download_path
      end

      downloads
    end

    it 'downloads all files from HTTP folder' do
      subject.size.must_equal 1
    end

    it 'doesnt create corrupt file' do
      downloaded_checksum = Digest::MD5.file(subject.first).hexdigest
      downloaded_checksum.must_equal file_checksum
    end
  end
end
