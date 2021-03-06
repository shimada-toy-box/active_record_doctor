source 'https://rubygems.org'
gemspec path: File.join(File.dirname(__FILE__), '..')

 git_source(:github) { |repo_name| "https://github.com/#{repo_name}.git" }

 gem 'rails', '~> 5.2', github: 'rails/rails', branch: '5-2-stable'

# Older versions result in lots of warnings in Ruby 2.7.
gem 'pg', '>= 1.2.0'
