require_relative 'lib/scan_output_transformation/version'

Gem::Specification.new do |s|
  s.name          = "scan_output_transformation"
  s.version       = ScanOutputTransformation::VERSION
  s.summary       = "Export scan data"
  s.description   = %q{ Gem to read scans from produtil and export them to files. For now, only exporting is to CSV }
  s.authors       = ["Daniel Moreto"]
  s.files         = Dir["lib/scan_output_transformation/*.rb"]
  s.executables   = ["scan_output"]

  s.add_dependency  "net-scp", "~> 1.2"
end
