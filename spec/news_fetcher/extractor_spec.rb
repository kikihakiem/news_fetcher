require 'test_helper'

describe NewsFetcher::Extractor do
  describe 'each_xml' do
    before do
      zip_file_path = File.expand_path('spec/fixtures/compressed.zip')
      @entries = []
      NewsFetcher::Extractor.each_xml(zip_file_path) do |filename, content|
        @entries << {filename: filename, content: content}
      end
    end

    it 'iterates all zip file entries' do
      @entries.size.must_equal 2
    end

    it 'yields entry content' do
      @entries.first[:filename].must_equal 'file1.txt'
      @entries.first[:content].must_equal 'file1 content'
      @entries.last[:filename].must_equal 'file2.txt'
      @entries.last[:content].must_equal 'content of file2'
    end
  end
end
