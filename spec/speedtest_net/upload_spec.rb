# frozen_string_literal: true

RSpec.describe SpeedtestNet::Upload do
  describe '.measure' do
    let(:config) { build(:config) }
    let(:server) { build(:server) }
    let(:multi_mock) { instance_double(Curl::Multi) }
    let(:easy_mock) { instance_double(Curl::Easy) }
    let(:post_mock) { instance_double(Curl::PostField) }

    before do
      allow(SpeedtestNet::Config).to receive(:fetch).and_return(config)
      allow(Curl::Multi).to receive(:new).and_return(multi_mock)
      allow(Curl::Easy).to receive(:new).and_return(easy_mock)
      allow(Curl::PostField).to receive(:content).and_return(post_mock)
      allow(multi_mock).to receive(:add)
      allow(multi_mock).to receive(:perform)
      allow(easy_mock).to receive_messages(headers: {}, http_post: post_mock)
      allow(easy_mock).to receive(:on_complete).and_yield(easy_mock)
      allow(easy_mock).to receive(:upload_speed).and_return(0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0)
    end

    it 'was valid' do
      expect(described_class.measure(server)).to be_instance_of(SpeedtestNet::MeasureResult)
    end
  end
end
