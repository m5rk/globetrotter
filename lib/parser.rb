require 'nokogiri'

require 'destination'
require 'taxonomy_node'

class Parser
  attr_accessor \
    :destinations_doc,
    :output_path,
    :taxonomy_doc

  def initialize(options = {})
    @destinations_doc = Nokogiri::XML(File.open(options.fetch(:destinations)))
    @taxonomy_doc = Nokogiri::XML(File.open(options.fetch(:taxonomy)))

    @output_path = options.fetch(:output_path)
  end

  def taxonomy_nodes_by_id
    @nodes_by_id ||= taxonomy_doc.xpath('//node').each_with_object({}) do |node, memo|
      memo[node['atlas_node_id']] = TaxonomyNode.new(node)
    end
  end

  def destinations
    @destinations ||= destinations_doc.xpath('//destination').map do |destination|
      taxonomy_node = taxonomy_nodes_by_id[destination['atlas_id']]
      Destination.new(destination, taxonomy_node, output_path)
    end
  end

  def renderer
    @renderer ||= ERB.new(File.open('template.erb').read)
  end

  def parse!
    destinations.each do |destination|
      destination.write(renderer)
    end
  end
end

