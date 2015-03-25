require 'spec_helper'

require 'runner'

describe Runner do
  describe '.main' do
    let(:incomplete_argv) { [] }
    let(:complete_argv) { ['-ddestinations.xml', '-ttaxonomy.xml', '-ooutput_path'] }

    context 'when a required option is missing', :console do
      it 'raises an error without invoking the Parser' do
        expect(Parser).not_to receive :new

        expect { Runner.main(incomplete_argv) }.to raise_error(SystemExit)
      end
    end

    context 'when all options are specified' do
      let(:parser_double) { instance_double('Parser') }
      let(:options) do
        {
          destinations: 'destinations.xml',
          taxonomy: 'taxonomy.xml',
          output_path: 'output_path'
        }
      end

      it 'creates a Parser with the expected options and sends :parse! to it' do
        expect(parser_double).to receive(:parse!)
        expect(Parser).to receive(:new).with(options).and_return parser_double

        Runner.main(complete_argv)
      end
    end
  end
end
