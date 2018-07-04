#! /usr/bin/env ruby
require_relative 'loader'
require_relative 'transformer'
require_relative 'dumper'

  csv_options = {
      encoding: Encoding::UTF_8,
      headers: true,
      quote_char: '"',
      col_sep: ';',
      force_quotes: true,
      skip_lines: nil
    }
dumper = Dumper.new(csv_options)

Loader.new(csv_options: csv_options).load.each do |file, table|
  data = Transformer.new(table).call
  dumper.dump(data, file)
end
