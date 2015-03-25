require 'erb'

class Destination
  attr_accessor \
    :destination_node,
    :output_path,
    :taxonomy_node

  def initialize(destination_node, taxonomy_node, output_path)
    @destination_node = destination_node
    @taxonomy_node = taxonomy_node
    @output_path = output_path

    ensure_output_path!
  end

  def node_id
    destination_node['atlas_id']
  end

  def children
    taxonomy_node.children
  end

  def content
    destination_node.xpath('./introductory/introduction/overview').first.text
  end

  def name
    destination_node['title-ascii']
  end

  def parent
    taxonomy_node.parent
  end

  def file_contents
    return unless File.exist?(filename)

    File.open(filename).read
  end

  def filename
    File.join(output_path, taxonomy_node.href)
  end

  def write(renderer)
    File.open(filename, 'w') do |writer|
      writer.write(renderer.result(binding))
    end
  end

  def ensure_output_path!
    Dir.mkdir(output_path) unless Dir.exist?(output_path)
  end
end
