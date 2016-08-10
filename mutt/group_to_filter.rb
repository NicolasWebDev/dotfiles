#! /usr/bin/env ruby
GROUP_FILE = ARGV[0].freeze
addresses = File.read(GROUP_FILE).split "\n"
filters = addresses.map { |elt| "~f #{elt} | ~t #{elt}" }
filter = filters.join ' | '
puts filter
