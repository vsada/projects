module ScanOutputTransformation

  module ScanOutputLog

    HEADER = ["Host", "Log"]

    def self.insert(host, log)
      @log ||= {}
      @log["#{host}"] = log
    end


    def self.to_csv(file_path)
      CSV.open(file_path, "w", write_headers: true, headers: HEADER, col_sep: ";") do |row|
        @log.each do |key, value|
          row << [key, value]
        end
      end
    end

  end

end
