require 'optparse'
require 'parser'

class Runner
  def self.main(argv)
    options = {}
    option_parser = OptionParser.new do |opts|
      opts.on('-dDESTINATION', '--destinations DESTINATIONS',
        'Location of the destinations file') do |destinations|

        options[:destinations] = destinations
      end

      opts.on('-tTAXONOMY', '--taxonomy TAXONOMY',
        'Location of the taxonomy file') do |taxonomy|

        options[:taxonomy] = taxonomy
      end

      opts.on('-oOUTPUT_PATH', '--output_path OUTPUT_PATH',
        'Path to store OUTPUT') do |output_path|

        options[:output_path] = output_path
      end
    end

    option_parser.parse!(argv)

    required = [:destinations, :taxonomy, :output_path]
    missing = required - options.keys

    if missing.any?
      puts "Error: Missing: #{missing.join(', ')}"
      puts option_parser.help

      exit 1
    end

    parser = Parser.new(options)
    parser.parse!
  end
end
