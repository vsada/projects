module ScanOutputTransformation

  require 'fileutils'
  require_relative "./constants.rb"

  class ScanMapping

    include ScanOutputTransformation::Constants

    def initialize(file_path = nil)
      @file_path = file_path
      @local_mapping_path = "#{Dir.pwd}/mapping"
      @remote_mapping_path = "#{ROOT_REMOTE}/cmdb/conf"
    end


    def get(type, product_name)
      @mapping ||= build_mapping
      @mapping["#{type}.#{product_name}"] || empty_mapping
    end


    private


    def build_mapping
      download_mapping_file if @file_path.nil?
      mapping = {}
      begin
        CSV.foreach(@file_path, col_sep: ",") do |row|
          mapping.merge!({ "#{row[0]}" => row[1..-1] })
        end
      rescue Exception => e
        puts "There is a error when trying to open mapping file. Please, verify if this file really exists and its permissions."
        exit
      end
      mapping
    end


    def download_mapping_file
      create_dir(@local_mapping_path) unless dir_exists?(@local_mapping_path)
      @file_path = "#{@local_mapping_path}/appmapping.csv"
      Net::SCP.start(SSH_HOST, SSH_USER, password: SSH_PASS) do |scp|
        scp.download("#{@remote_mapping_path}/appmapping.csv", @file_path)
      end
    end


    def empty_mapping
      ["", "", ""]
    end


    def dir_exists?(dir)
      File.directory?(dir)
    end


    def create_dir(dir)
      FileUtils.mkdir_p dir
    end
  end

end
