# Novofon

## Installation

Add this line to your application's Gemfile:

    gem "novofon"

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install novofon

## Usage

    Novofon.api_key = "YOUR_API_KEY"
    Novofon.api_secret = "YOUR_API_SECRET"
    Novofon.log_requests = false # default

    Novofon::Client.balance
or

    client = Novofon::Client.new("YOUR_API_KEY", "YOUR_API_SECRET")
    client.balance
