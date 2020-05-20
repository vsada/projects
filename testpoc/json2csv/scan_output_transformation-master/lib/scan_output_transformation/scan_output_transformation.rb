require_relative "get_scans"
require_relative "extract_files"
require_relative "read_hosts_files"
require_relative "build_csv"
require_relative "scan_output_log"

module ScanOutputTransformation

  def self.to_csv(client_name, client_prefix, output_dir: nil, scan_location: nil, extract_dir: nil, map_file: nil)
    client_files_location = build_client_path(scan_location, client_prefix)
    client_scan_location = extract_files(client_files_location, extract_dir, client_prefix)
    puts "Reading Files"
    read_files = ReadHostsFiles.new(client_scan_location)
    puts "Creating CSV"
    build_csv(client_name, client_prefix, read_files.bulk_process, output_dir, map_file)
    puts "Process finished"
    ScanOutputTransformation::ScanOutputLog.to_csv("#{output_dir}/scan_#{client_prefix}_log_#{Time.now.strftime('%Y-%m-%d')}.csv")
  end


  private


  def self.build_csv(client_name, client_prefix, read_json, output_dir, map_file)
    build_csv = BuildCSV.new(client_name, read_json, map_file_path: map_file)
    output_dir += "\/" if output_dir && !output_dir.empty? && output_dir[-1] != "\/"
    file_partial_name = "#{client_prefix}_#{Time.now.strftime("%Y-%m-%d")}.csv"
    build_csv.inventory("#{output_dir}inventory_#{file_partial_name}")
    build_csv.middleware("#{output_dir}middleware_#{file_partial_name}")
    build_csv.instance("#{output_dir}instance_#{file_partial_name}")
  end


  def self.build_client_path(scan_location, client_prefix)
    if scan_location.nil?
      client_path = download_scans(client_prefix, scan_location)
      puts
      return client_path
    end
    "#{scan_location}/#{client_prefix}"
  end


  def self.extract_files(origin_dir, extract_dir, client_prefix)
    extract_dir = "#{extract_dir}/#{client_prefix}" unless extract_dir.nil?
    extract_dir ||= "./extract_files/#{client_prefix}"
    puts "Extracting files"
    ExtractFiles.new(origin_dir, dest_dir: extract_dir).start
    extract_dir
  end


  def self.download_scans(client_prefix, scan_dir)
    @get_scans = GetScans.new(client_prefix, dest_dir: scan_dir)
    saved_scans = @get_scans.start
    client_path = "#{saved_scans}/#{client_prefix}"
    client_path
  end

end
