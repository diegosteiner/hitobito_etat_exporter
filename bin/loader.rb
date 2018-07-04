require 'csv'

class Loader
  attr_reader :files, :csv_options

  def initialize(files: Dir[File.join(File.dirname(__dir__), 'raw', '*.csv')], csv_options: {})
    @files = files
    @csv_options = csv_options
  end

  def load_file(file)
    puts file
    [file, CSV.read(file, csv_options)]
  rescue CSV::MalformedCSVError => error
    nil
  end

  def load(files = @files)
    Hash[files.map { |file| load_file(file) }]
  end
end

