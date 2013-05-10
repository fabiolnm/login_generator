# run with
# $ ruby lib/login_generator/profile.rb
require_relative '../login_generator'
require_relative 'subject'

s = Subject.new
s.email = "johnlennon@beatles.com.br"
%w{johnle johnl john}.each { |prefix|
  s.use_logins prefix, 100..99999
}

require 'profile'
p s.generate
