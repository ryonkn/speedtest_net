# SpeedtestNet

[![Gem Version](https://badge.fury.io/rb/speedtest_net.svg)](https://badge.fury.io/rb/speedtest_net)
[![Actions Status](https://github.com/ryonkn/speedtest_net/workflows/GitHub%20Actions/badge.svg)](https://github.com/ryonkn/speedtest_net/actions)
[![Codacy Badge](https://api.codacy.com/project/badge/Grade/18f112dae19a48938bdf2b225d3a76bb)](https://www.codacy.com/manual/ryonkn/speedtest_net?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=ryonkn/speedtest_net&amp;utm_campaign=Badge_Grade)

A Ruby library for testing internet bandwidth using speedtest.net

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'speedtest_net'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install speedtest_net

## Usage

```ruby
require 'speedtest_net'
```

### Run speedtest

```ruby
result = SpeedtestNet.run                    # SpeedtestNet::Result instance
result.server                                # server environment in speedtest
result.client                                # client environment in speedtest
result.latency                               # latency in speedtest
result.download                              # download bit/second in speedtest
result.upload                                # upload bit/second in speedtest
result.pretty_latency                        # pretty format for latency in speedtest
result.pretty_download                       # pretty format for download bit/second in speedtest
result.pretty_upload                         # pretty format for upload bit/second in speedtest
```

## Contributing

1. Fork it ( https://github.com/ryonkn/speedtest_net/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the SpeedtestNet project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/ryonkn/speedtest_net/blob/master/CODE_OF_CONDUCT.md).
