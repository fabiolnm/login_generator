require_relative "login_generator/version"
require 'active_support/core_ext/string'

module LoginGenerator
  def generate
    unless email.blank?
      prefix = email.split("@").first

      len = prefix.length
      min, max = [ 3, len ].min, [ 5, len ].min

      res = generate_with_prefix_and_size prefix, min, max
      res = generate_with_prefix_and_size(prefix, 6, len, false) if res.blank?
      res
    end
  end

  def generate_with_prefix_and_size prefix, min, max, reverse=true
    range = (min..max).to_a
    range.reverse! if reverse
    res = nil
    range.each {|i|
      v = generate_with_prefix prefix[0..i]
      break res = v if v
    }
    res
  end

  def generate_with_prefix prefix
    res = nil
    (2..4).each {|i|
      min, max = 10**i, 10**(i+1)-1
      available_sufixes = (min..max).to_a - sufixes_in_use(prefix)

      sufix = available_sufixes.shuffle.first
      break res = "#{prefix}#{sufix}" if sufix
    }
    res
  end
end

