module ScanOutputTransformation

  require_relative "./constants.rb"

  class ExtractFiles

    include ScanOutputTransformation::Constants

    def initialize(client_dir, dest_dir: nil)
      @origin_path = client_dir
      @dest_path = dest_dir || @origin_path
    end


    def start
      Dir.glob("#{@origin_path}/*{tgz,zip}").each do |filename|
        hostname = filename.split('/').last.split('.').first
        extract_file(filename, hostname)
      end
    end


    private


    def extract_file(filename, hostname)
      begin
        FileUtils.mkdir_p "#{@dest_path}/#{hostname}"
        unpack_file(filename, "#{@dest_path}/#{hostname}")
      rescue => e
        puts e.message
        ScanOutputTransformation::ScanOutputLog.insert hostname, e.message
      end
    end


    def unpack_file(file, dest_path)
      if file.include?('.zip')
        %x{ unzip -o #{file} -d #{dest_path}/ >/dev/null 2>&1 }
      else
        %x{ tar zxf #{file} -C #{dest_path}/ >/dev/null 2>&1 }
      end
      raise "#{file}: There is an error on this file. Please check if it empty or its size is 0" unless $? == 0
    end

  end

end
