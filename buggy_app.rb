#!/usr/bin/env ruby

require "rubygems"
require 'bundler/setup'

require "json"
require "faker"
require "time"

LOG_FILE = "bugsnag.log"
SLEEP_PERIOD = 1..2000

def generate_error_payload(api_key)
  JSON.generate({
    :apiKey => api_key,
    :notifier => {
      :name => "Bugsnag Ruby",
      :version => "0.0.1",
      :url => "https://github.com/bugsnag/bugsnag-challenge"
    },
    :events => [{
      :userId => Faker::Internet.email,
      :appVersion => rand(1..100).to_s,
      :osVersion => rand(1..100).to_s,
      :releaseStage => "production",
      :context => Faker::Name.name,
      :metaData => {},
      :exceptions => [{
        :errorClass => Faker::Name.name,
        :message => Faker::Lorem.sentence,
        :stacktrace => [{
          :file => Faker::Lorem.word,
          :lineNumber => rand(1..200),
          :method => Faker::Lorem.word,
          :inProject => rand(1..2) == 2
        },{
          :file => Faker::Lorem.word,
          :lineNumber => rand(1..200),
          :method => Faker::Lorem.word,
          :inProject => rand(1..2) == 2
        }]
      }]
    }]
  })
end

def crash_repeatedly(api_key)
  while true do
    puts "#{Time.now.utc.iso8601(3)} - Writing error payload to #{LOG_FILE}"

    file = File.open(LOG_FILE, "a") if !file || file.closed?
    payload = "#{generate_error_payload(api_key)}\n"

    if rand(0..20) == 0
      payload = payload[0..rand(50..400)]
      file.write payload
      file.close
    else
      file.write payload
      file.flush
    end

    sleep rand(SLEEP_PERIOD)/1000.0
  end

  file.close
end

if ARGV.length == 1
  crash_repeatedly(ARGV.first)
else
  puts "Usage: ./buggy_app.rb [bugsnag-api-key]"
end