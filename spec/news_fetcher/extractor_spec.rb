require 'test_helper'

describe NewsFetcher::Extractor do
  describe 'each_xml' do
    let(:zip_file_path) { File.expand_path('spec/fixtures/compressed.zip') }

    subject do
      entries = []
      NewsFetcher::Extractor.each_xml(zip_file_path) do |filename, content|
        entries << {filename: filename, content: content}
      end

      entries
    end

    it 'iterates all zip file entries' do
      subject.size.must_equal 2
    end

    it 'yields entry content' do
      subject.first[:filename].must_equal 'file1.txt'
      subject.first[:content].must_equal 'file1 content'
      subject.last[:filename].must_equal 'file2.txt'
      subject.last[:content].must_equal 'content of file2'
    end
  end
end
