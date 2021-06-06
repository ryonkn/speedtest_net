# frozen_string_literal: true

RSpec.describe SpeedtestNet::Config do # rubocop:disable Metrics/BlockLength
  before { described_class.instance_variable_set :@instance_cache, nil }

  let(:config) { build(:config) }

  describe '.fetch' do
    context 'when access was' do
      it 'success', vcr: { cassette_name: 'config' } do
        expect(described_class.fetch).to be_instance_of(described_class)
      end
    end

    context 'when access error was' do
      before do
        curl_mock = instance_double(Curl::Easy)
        allow(Curl::Easy).to receive(:new).and_return(curl_mock)
        allow(curl_mock).to receive_messages('follow_location=': true,
                                             perform: true,
                                             response_code: 500)
      end

      it 'raise error' do
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
    it 'was valid' do
      expect(config.client.isp).to eq('example isp')
    end

    context 'when access geo' do
      it 'was Geo instance' do
        expect(config.client.geo).to be_kind_of(SpeedtestNet::Geo)
      end
    end
  end

  describe '#server' do
    it 'was valid' do
      expect(config.server).to include(threadcount: 1, forcepingid: '',
                                       preferredserverid: '')
    end

    context 'when access :ignoreids' do
      it 'was valid', vcr: { cassette_name: 'config' } do
        expect(config.server[:ignoreids]).to include(1, 2, 3)
      end
    end

    context 'when access :notonmap' do
      it 'was valid' do
        expect(config.server[:notonmap]).to include(4, 5, 6)
      end
    end
  end

  describe '#download' do
    it 'was valid' do
      expect(config.download).to include(testlength: 1, initialtest: '250K',
                                         mintestsize: '250K', threadsperurl: 1)
    end
  end

  describe '#upload' do
    it 'was valid' do
      expect(config.upload).to include(testlength: 1, initialtest: 1,
                                       threads: 1, maxchunkcount: 1,
                                       maxchunksize: '512K', threadsperurl: 1)
    end
  end

  describe '#latency' do
    it 'was valid' do
      expect(config.latency).to include(testlength: 0, waittime: 50,
                                        timeout: 20)
    end
  end
end
