# Novofon

Novofon — Virtual Phone System, Phone numbers and PBX  
[Official documentation API Novofon](https://novofon.com/instructions/api/)

## Installation

Add this line to your application's Gemfile:

`gem "novofon"`

And then execute:

`bundle install`

Or install it yourself as:

`gem install novofon`

## Usage

```ruby
Novofon.api_key = "YOUR_API_KEY"
Novofon.api_secret = "YOUR_API_SECRET"
Novofon.log_requests = false # default

Novofon::Client.balance
```

or

```ruby
client = Novofon::Client.new("YOUR_API_KEY", "YOUR_API_SECRET")
client.balance
```

## Available methods

You can use the available methods or use `.request`

```ruby
Novofon::Client.request(:method, "path", params = {})
Novofon::Client.request(:get, "/info/balance/")
```

* `balance` - user balance
* `price(number)` - call price
* `callback(from, to, params = {})` - request callback
* `checknumber(caller_id, to, code, params = {})` - number verification
* `sip` - list user’s SIP-numbers
* `set_sip_caller(id, number)` - change of CallerID
* `redirection(params = {})` - get call forwarding status on SIP-numbers
* `set_redirect(id, params)` - enable/disable sip forwarding
* `pbx_internal` - list PBX internal numbers
* `pbx_record(id, status, params = {})` - toggle call recording
* `send_sms(number, message, params = {})` - send sms
* `statistics(date_start, date_end, params = {})` - get stats
* `pbx_statistics(date_start, date_end)` - get PBX stats
* `direct_numbers` - information about the user's phone numbers
* `direct_numbers_available(direction_id)` - numbers available for order
* `direct_numbers_countries` - list of countries numbers can be ordered from
