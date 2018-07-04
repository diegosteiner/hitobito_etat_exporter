require 'csv'

class Dumper
  attr_reader :csv_options

  def initialize(csv_options)
    @csv_options = csv_options
  end

  def dump(data, source_file)
    return unless data && source_file
    target_file = File.realdirpath(File.join(File.dirname(source_file), '..', 'out', File.basename(source_file)))
    CSV.open(target_file, 'wb') do |csv|
      csv << data.first.keys
      data.each do |row|
        csv << row.values
      end
    end
  end
end

