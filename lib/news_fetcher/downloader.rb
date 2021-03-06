require 'typhoeus'

module NewsFetcher
  class Downloader
    def self.each_zip(http_folder, max_zip_files)
      hydra = Typhoeus::Hydra.new(max_concurrency: 20)
      download_path = File.expand_path('downloads')
      zip_file_count = 0

      response = Typhoeus.get(http_folder)
      response.body.scan(/>(\d+.zip)</) do |path|
        filename = path.first
        file_path = "#{download_path}/#{filename}"
        file_url = "#{http_folder}#{filename}"
        # skip if file is already processed
        # redownload if file corrupted
        next if File.exist?(file_path) && Extractor.valid_zip?(file_path)
        
        request = on_complete_request(file_url, file_path) do |zip_file_path|
          # yield when download is completed
          yield zip_file_path
        end
        hydra.queue(request)

        zip_file_count += 1
        break if max_zip_files && zip_file_count >= max_zip_files
      end

      hydra.run
      zip_file_count
    end

    def self.on_complete_request(file_url, local_path)
      zip_file = nil
      request = Typhoeus::Request.new(file_url)
      request.on_body do |chunk|
        # need to put File.open here,
        # otherwise it will be 'too many open files' error
        zip_file ||= File.open(local_path, 'wb')
        zip_file.write(chunk)
      end

      request.on_complete do |ignored|
        zip_file.close
        yield zip_file.path
      end

      request
    end
  end
end