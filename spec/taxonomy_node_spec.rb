require 'spec_helper'

require 'taxonomy_node'

describe TaxonomyNode do
  let(:xml_node) { taxonomy_xml_node }
  let(:taxonomy_node) { TaxonomyNode.new(xml_node) }

  describe '#node_id' do
    it 'is the expected value' do
      expect(taxonomy_node.node_id).to eq '355064'
    end
  end

  describe '#href' do
    context 'when there is a node id' do
      it 'is the filename' do
        expect(taxonomy_node.href).to eq '355064.html'
      end
    end

    context 'when there is not a node id' do
      let(:xml_node) { taxonomy_xml_node.tap { |node| node.delete('atlas_node_id') } }

      it 'is nil' do
        expect(taxonomy_node.href).to be_nil
      end
    end
  end

  describe '#filename' do
    it 'is the node id with the .html extension' do
      expect(taxonomy_node.filename).to eq '355064.html'
    end
  end

  describe '#parent' do
    it 'is the parent node' do
      expect(taxonomy_node.parent.name).to eq 'World'
    end
  end

  describe '#name' do
    context 'when it is a normal node' do
      it 'is the node_name text' do
        expect(taxonomy_node.name).to eq 'Africa'
      end
    end

    context 'when it is the root taxonomy node' do
      let(:xml_node) { root_taxonomy_xml_node }

      it 'is the node_name text' do
        expect(taxonomy_node.name).to eq 'World'
      end
    end
  end

  describe '#children' do
    it 'is an array of the children of the node' do
      expect(taxonomy_node.children.map { |child| child.name }).to eq(["South Africa", "Sudan", "Swaziland"])
    end
  end
end
