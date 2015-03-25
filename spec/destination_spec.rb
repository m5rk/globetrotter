require 'spec_helper'

require 'destination'

describe Destination do
  let(:taxonomy_node) { TaxonomyNode.new(taxonomy_xml_node) }
  let(:output_path) { 'output' }
  let(:destination) { Destination.new(destination_xml_node, taxonomy_node, 'output') }

  describe '#node_id' do
    it 'is the expected value' do
      expect(destination.node_id).to eq '355064'
    end
  end

  describe '#children' do
    it 'is a list of the child nodes from the taxonomy document' do
      expected = ["South Africa", "Sudan", "Swaziland"]

      expect(destination.children.map { |child| child.name }).to eq(expected)
    end
  end

  describe '#content' do
    it 'is the introductory overview' do
      expect(destination.content).to include('How do you capture the essence of Africa on paper')
    end
  end

  describe '#name' do
    it 'is the title-ascii attribute' do
      expect(destination.name).to eq 'Africa'
    end
  end

  describe '#parent' do
    it 'is the parent node from the taxonomy document' do
      expect(destination.parent.name).to eq 'World'
    end
  end

  describe '#write' do
    let(:renderer) { instance_double('ERB') }
    let(:filename) { destination.filename }

    before do
      FileUtils.rm(filename) if File.exist?(filename)
    end

    it 'writes the result from the renderer to the file' do
      expect(renderer).to receive(:result).with(any_args).and_return 'the result'

      expect { destination.write(renderer) }.to change { destination.file_contents }.to('the result')
    end
  end
end
