require 'simplecov'

SimpleCov.start do
  add_filter '/spec/'
end

RSpec.configure do |config|
  config.before(:context, console: true, &:silence_output)
  config.after(:context, console: true, &:enable_output)
end

def valid_options
  {
    destinations: File.expand_path('../destinations.xml', File.dirname(__FILE__)),
    taxonomy: File.expand_path('../taxonomy.xml', File.dirname(__FILE__)),
    output_path: 'output'
  }
end

def destination_xml_node
  parser = Parser.new(valid_options)
  parser.destinations.first.destination_node
end

def taxonomy_xml_node
  parser = Parser.new(valid_options)
  parser.taxonomy_nodes_by_id.values.first.node
end

def root_taxonomy_xml_node
  parser = Parser.new(valid_options)
  parser.taxonomy_doc.xpath('.//taxonomy').first
end

public

def silence_output
  @original_stderr = $stderr
  @original_stdout = $stdout

  $stderr = File.new('/dev/null', 'w')
  $stdout = File.new('/dev/null', 'w')
end

def enable_output
  $stderr = @original_stderr
  $stdout = @original_stdout

  @original_stderr = nil
  @original_stdout = nil
end
