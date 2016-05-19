require 'news_fetcher/version'
require 'news_fetcher/downloader'
require 'news_fetcher/extractor'

module NewsFetcher
  def self.each_news(http_folder, max_zip_file = 1, max_news_count = 10)
    news_count = 0
    Downloader.each_zip(http_folder, max_zip_file) do |zip_file_path|
      Extractor.each_xml(zip_file_path) do |filename, xml|
        yield [strip_extension(filename), xml]

        news_count += 1
        break if news_count >= max_news_count
      end
    end
  end

  def self.strip_extension(filename)
    filename.split('.').first
  end
end
