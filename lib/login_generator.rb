require "login_generator/version"
require 'active_support/core_ext/string'

module LoginGenerator
  def generate
    unless email.blank?
      prefix = email.split("@").first

      len = prefix.length
      min, max = [ 3, len ].min, [ 5, len ].min

      res = generate_with_prefix_and_size prefix, min, max
      generate_with_prefix_and_size(prefix, 6, len, false) if res.blank?
    end
  end

  def generate_with_prefix_and_size prefix, min, max, reverse=true
    range = [min..max].to_a
    range.reverse if reverse
    range.each {|i| break v if v = generate_with_prefix(prefix[0..i]) }
  end

  def generate_with_prefix prefix
    sufixes_in_use = logins_in_use.map { |login|
      login.gsub(prefix, '').to_i
    }.select { |s| s > 0 }

    res = nil
    (3..5).each {|i|
      available_sufixes = (10**i..10**(i+1)).to_a - sufixes_in_use
      sufix = available_sufixes.shuffle.first
      res = "#{prefix}#{sufix}"
      break res unless logins_in_use.include? res
    }
  end
end
