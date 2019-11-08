# frozen_string_literal: true

RSpec.describe SpeedtestNet::Config do
  before { described_class.instance_variable_set :@instance_cache, nil }

  let(:config) { described_class.fetch }

  describe '.fetch' do
    context 'when access was' do
      it 'success', vcr: { cassette_name: 'config' } do
        expect(config).to be_instance_of(described_class)
      end
    end

    context 'when access error was' do
      it 'raise error' do
        curl_mock = instance_double(Curl::Easy)
        allow(Curl::Easy).to receive(:new).and_return(curl_mock)
        allow(curl_mock).to receive_messages('follow_location=': true,
                                             perform: true,
                                             response_code: 500)

        expect { described_class.fetch }.to raise_error(
          SpeedtestNet::HTTPDownloadError
        )
      end
    end
  end

  describe '.clear_cache' do
    context 'when' do
      it 'success', vcr: { cassette_name: 'config' } do
        described_class.fetch
        described_class.clear_cache
        expect(described_class.instance_variable_get(:@instance_cache))
          .to be_nil
      end
    end
  end

  describe '#client' do
    it 'was valid', vcr: { cassette_name: 'config' } do
      expect(config.client).to include(ip: '192.0.2.1', isp: 'EXAMPLE ISP')
    end

    context '[:geo]' do
      it 'was Geo instance', vcr: { cassette_name: 'config' } do
        expect(config.client[:geo]).to be_kind_of(Geo)
      end
    end
  end
end
