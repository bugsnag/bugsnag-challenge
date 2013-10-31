#!/usr/bin/env ruby

require "rubygems"
require 'bundler/setup'

require "json"
require "faker"

def error_payload
  JSON.generate({
    api_key: "4a6a484e14e18cccd6effde6db6e297e",
    notifier: {
      name: "Bugsnag Ruby",
      version: "0.0.1",
      url: "https://github.com/bugsnag/bugsnag-challenge"
    },
    events: [{
      userId: Faker::Internet.email,
      appVersion: rand(1..100),
      osVersion: rand(1..100),
      releaseStage: "production",
      context: Faker::Name.name,
      metaData: {},
      exceptions: [{
        errorClass: Faker::Name.name,
        message: Faker::Lorem.sentence,
        stacktrace: [{
          file: Faker::Lorem.word,
          lineNumber: rand(1..200),
          method: Faker::Lorem.word,
          inProject: rand(1..2) == 2
        },{
          file: Faker::Lorem.word,
          lineNumber: rand(1..200),
          method: Faker::Lorem.word,
          inProject: rand(1..2) == 2
        }]
      }]
    }]
  })
end

while true do
  File.open("bugsnag.log", "a") { |file| file.write "#{error_payload}\n" }
  sleep 1
end