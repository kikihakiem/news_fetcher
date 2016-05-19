require 'zip'

module NewsFetcher
  class Extractor
    def self.each_xml(zip_file_path)
      Zip::File.open(zip_file_path) do |file|
        file.each do |entry|
          file_name = entry.name
          content = entry.get_input_stream.read

          yield [file_name, content] if entry.file?
        end
      end
    end

    def self.valid_zip?(file)
      zip = Zip::File.open(file)
      true
    rescue StandardError
      false
    ensure
      zip.close if zip
    end
  end
end