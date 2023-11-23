require 'rails/all'
require 'json'
require_relative 'constants'

suffixes = SUFFIXES.map {|suffix| suffix.gsub("?", "\\?") + '$'}
exp_pattern = Regexp.new(suffixes.join('|'))

matches = KLASSES.flat_map do |klass|
  { "#{klass}": klass.methods.grep(exp_pattern) + klass.instance_methods.grep(exp_pattern) }
end.to_json

File.open('result.json', 'w') do |file|
  file.write(matches)
end
