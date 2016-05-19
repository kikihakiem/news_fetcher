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
        full_path = "#{download_path}/#{filename}"
        # skip if file is already processed
        # redownload if file corrupted
        next if File.exist?(full_path) && Extractor.valid_zip?(full_path)
        
        request = create_request(http_folder, filename, full_path) do |local_path|
          yield local_path
        end
        hydra.queue(request)

        zip_file_count += 1
        break if zip_file_count >= max_zip_files
      end

      hydra.run
    end

    def self.create_request(http_folder, filename, local_path)
      zip_file = nil
      request = Typhoeus::Request.new("#{http_folder}#{filename}")
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