module ScanOutputTransformation

  class GetScans
    require 'fileutils'
    require 'net/ssh'
    require 'net/scp'
    require_relative "./constants.rb"

    include ScanOutputTransformation::Constants

    def initialize(client_prefix, dest_dir: nil)
      @local_scan_path  = dest_dir || "#{Dir.pwd}/scans"
      @server_scan_path = "#{RESULTS_REMOTE}/#{client_prefix}"
    end


    def start
      create_dir(@local_scan_path) unless dir_exists?(@local_scan_path)

      Net::SCP.start(SSH_HOST, SSH_USER, password: SSH_PASS) do |scp|
        scp.download("#{@server_scan_path}", "#{@local_scan_path}", { recursive: true }) do |ch, name, received, total|
          percentage = format('%.2f', received.to_f / total.to_f * 100) + '%'
          print "Saving: Received #{received} of #{total} bytes" + " (#{percentage})               \r"
          STDOUT.flush
        end
      end

      @local_scan_path
    end


    private


    def dir_exists?(dir)
      File.directory?(dir)
    end


    def create_dir(dir)
      FileUtils.mkdir_p dir
    end
  end

end
