class Subject
  include LoginGenerator

  attr_accessor :email

  def logins_in_use
    @logins_in_use ||= []
  end

  def sufixes_in_use prefix
    @sufixes_in_use         ||= {}
    @sufixes_in_use[prefix] ||= []
  end

  def use_logins prefix, range
    sufixes_in_use(prefix).concat range.to_a
    range.each { |sufix| logins_in_use << "#{prefix}#{sufix}" }
  end
end
