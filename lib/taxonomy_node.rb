class TaxonomyNode
  attr_accessor :node

  def initialize(node)
    @node = node
  end

  def node_id
    node['atlas_node_id']
  end

  def href
    filename if node_id
  end

  def filename
    "#{node_id}.html"
  end

  def parent
    @parent ||= TaxonomyNode.new(node.parent)
  end

  def name
    @name ||= node.xpath('./node_name | ./taxonomy_name').first.text
  end

  def children
    @children ||= node.xpath('node').map do |child|
      TaxonomyNode.new(child)
    end
  end
end
