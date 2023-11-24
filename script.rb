# frozen_string_literal: true
require 'rails/all'
require 'json'
require_relative 'constants'

def retrieve_method_names(klasses, results = {})
  exp_pattern = Regexp.new(SUFFIXES.map {|suffix| ["#{suffix}$", "#{suffix}\\?$", "#{suffix}!$"]}.flatten.join('|'))
  results.tap do
    klasses.each do |klass|
      methods = (klass.methods + klass.instance_methods).grep(exp_pattern)
      results[klass] = methods unless methods.empty?
    end
  end
end

def append_results_to_file(results)
  File.open('result.json', 'w') do |file|
    file.write(results.to_json.gsub('\u003c', '<').gsub('\u003e', '>'))
  end
end

def main
  results = retrieve_method_names(ObjectSpace.each_object(Class))
  results = retrieve_method_names(KLASSES, results)
  append_results_to_file(results)
end

main
