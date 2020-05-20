module ScanOutputTransformation

  require 'csv'
  require_relative "scan_mapping"

  class BuildCSV

    INVENTORY_HEADER = [ "customer", "configuration_item_name", "operatingsystem_osname_osversion",
                         "model_object_last_scan", "Plataforma" ]

    SUBSYSTEM_HEADER = [ "customer", "configuration_item_name", "configuration_item_number", "classification", "summary",
                         "ismbr_vendor", "ismbr_swname", "ismbr_version", "ismbr_instancename", "model_object_last_scan",
                         "target_configuration_item_name", "target_classification", "target_model_object_last_scan" ]


    def initialize(customer, hosts_hash, map_file_path: nil)
      @customer = customer
      @hosts = hosts_hash
      @scan_mapping = ScanOutputTransformation::ScanMapping.new(map_file_path)
    end


    def inventory(dest_path = "inventory.csv")
      create_inventory(dest_path) do |row|
        @hosts.values.each do |host|
          row << inventory_fields(host)
        end
      end
    end


    def middleware(dest_path = "middleware.csv")
      filter_middleware = Proc.new { |subsystem| !instance_types.include?(subsystem['type']) }
      create_subsystem(dest_path, filter_middleware)
    end


    def instance(dest_path = "instance.csv")
      filter_instance = Proc.new { |subsystem| instance_types.include?(subsystem['type']) }
      create_subsystem(dest_path, filter_instance)
    end


    private


    def create_inventory(dest_path, &block)
      open_csv dest_path, INVENTORY_HEADER, block
    end


    def inventory_fields(host)
      platform = current_platform(host) =~ /Windows/ ? "Windows" : "Unix"
      csystem = host['computersystem']
      opeating_system = csystem['operating_system']
      os_name_version = "#{opeating_system['operatingsystem_osname']}, #{opeating_system['operatingsystem_osversion']}"
      [ @customer, csystem['ciname'], os_name_version, host['scan_time'], platform ]
    end


    def current_platform(host)
      host['computersystem']['operating_system']['operatingsystem_osname']
    end


    def create_subsystem(dest_path, filter)
      open_csv(dest_path, SUBSYSTEM_HEADER, Proc.new do |row|
        @hosts.values.each.each do |host|
          host['computersystem']['subsystems'].select(&filter).each { |subsystem| row << subsystem_fields(host, subsystem) }
        end
      end)
    end


    def subsystem_fields(host, subsystem)
      row = [ @customer, subsystem['ciname'], subsystem['cinum'] ]
      row = row + [ ismbr_fields(subsystem),  host['scan_time'],  target_fields(host) ]
      row.flatten
    end


    def target_fields(host)
      [ host['ciname'], host['computersystem']['classification'], host['scan_time'] ]
    end


    def ismbr_fields(subsystem)
      fields_from_mapping(subsystem) + [ subsystem['appserver_productversion'], subsystem['ciname'] ]
    end


    def fields_from_mapping(subsystem)
      mapping_result = @scan_mapping.get(subsystem['type'], subsystem['appserver_productname'])
      summary = "#{mapping_result[1]} #{subsystem['appserver_productversion']}"
      [ mapping_result[0], summary, mapping_result[2], mapping_result[1] ]
    end


    def open_csv(dest_path, headers, block)
      path = dest_path.split("/")[0..-2].join("/")
      create_dir(path) unless dir_exists?(path)
      CSV.open(dest_path, "w", write_headers: true, headers: headers, col_sep: ";", &block)
    end


    def instance_types
      ["DB2", "ORA"]
    end


    def dir_exists?(dir)
      File.directory?(dir)
    end


    def create_dir(dir)
      FileUtils.mkdir_p dir if dir != "./"
    end
  end

end
