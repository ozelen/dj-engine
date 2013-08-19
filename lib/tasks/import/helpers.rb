namespace :import do
  def hr length=100, sym='-'
    line = ""
    1.upto(length){|i| line+=sym}
    puts line
  end
end