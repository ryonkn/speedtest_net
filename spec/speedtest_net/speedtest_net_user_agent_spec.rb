# frozen_string_literal: true

RSpec.describe SpeedtestNet do
  it 'has a user_agent' do
    expect(SpeedtestNet::USER_AGENT).not_to be_nil
  end
end
