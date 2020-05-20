module ScanOutputTransformation

  class ReadHostsFiles

    require_relative "./constants.rb"
    require 'json'

    include ScanOutputTransformation::Constants

    def initialize(hosts_dir)
      @hosts_path = hosts_dir
    end


    def bulk_process
      hosts = {}
      Dir.glob("#{@hosts_path}/*").each do |item_dir|
        hosts.merge! read_host(item_dir.split("/").last) if File.directory?(item_dir)
      end
      hosts
    end


    def read_host(hostname)
      hostfile = "#{@hosts_path}/#{hostname}/#{hostname}.json"
      return {} unless File.exists?(hostfile)
      return {} unless host_json = read_json(hostfile, hostname)
      { "#{hostname}" => host_json }
    end


    private


    def read_json(hostfile, hostname)
      begin
        json_file = File.read(hostfile)
        JSON.parse(json_file)
      rescue
        ScanOutputTransformation::ScanOutputLog.insert hostname, "The host file #{hostfile} couldn't be read. Please, check it."
        return nil
      end
    end

  end

end
