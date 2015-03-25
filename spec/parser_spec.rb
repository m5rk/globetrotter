require 'spec_helper'

require 'parser'

describe Parser do
  describe '#initialize' do
    context 'when any of the required options is missing' do
      valid_options.keys.each do |without_key|
        it 'raises an error' do
          options = valid_options.delete_if do |key, value|
            key == without_key
          end

          expect { Parser.new(options) }.to raise_error(KeyError, "key not found: :#{without_key}")
        end
      end
    end
  end

  context 'when the required options are present' do
    let(:parser) { Parser.new(valid_options) }

    describe '#taxonomy_nodes_by_id' do
      let(:expected_keys) do
        ["355064", "355611", "355612", "355613", "355614", "355615", "355616", "355617", "355618", "355619", "355620", "355621", "355622", "355623", "355624", "355625", "355626", "355627", "355628", "355629", "355630", "355631", "355632", "355633"]
      end

      it 'is a Hash keyed by atlas_node_id' do
        expect(parser.taxonomy_nodes_by_id.keys).to eq(expected_keys)
      end

      it 'is a Hash of TaxonomyNode objects' do
        expect(parser.taxonomy_nodes_by_id.values.map { |v| v.class }.uniq).to eq([TaxonomyNode])
      end
    end

    describe '#destinations' do
      it 'is an Array of Destination objects' do
        expect(parser.destinations.map { |d| d.class }.uniq).to eq([Destination])
      end

      it 'has the expected first node_id' do
        expect(parser.destinations.first.node_id).to eq '355064'
      end

      it 'has the expected parent for the first node' do
        expect(parser.destinations.first.parent.name).to eq 'World'
      end
    end

    describe '#parse!' do
      before { FileUtils.rmtree(parser.output_path) if Dir.exist?(parser.output_path) }

      context 'when the output folder exists' do
        before { Dir.mkdir(parser.output_path) unless Dir.exist?(parser.output_path) }

        it 'does not attempt to create it' do
          expect(Dir).not_to receive(:mkdir)

          parser.parse!
        end
      end

      context 'when the output folder does not exist' do
        it 'creates it' do
          expect { parser.parse! }.to change { Dir.exist?(parser.output_path) }.to(true)
        end
      end

      it 'sends :write with the output to each destination' do
        parser.destinations.each do |destination|
          expect(destination).to receive(:write)
        end

        parser.parse!
      end
    end
  end
end
