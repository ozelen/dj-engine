namespace :import do
  def hr length=100, sym='-'
    line = ""
    1.upto(length){|i| line+=sym}
    puts line
  end

  def find_email(string)
    return nil if string.blank?
    r = Regexp.new(/\b[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}\b/) rescue nil
    string.scan(r).uniq[0]
  end

  def username_from_email email
    return nil if email.blank?
    r = email.scan(/^([^\.@]+)\.*([^@]*)/)
    r[0][0] rescue nil
  end

end