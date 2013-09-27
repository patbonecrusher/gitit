
puts __FILE__
puts File.dirname(__FILE__)
Dir[File.dirname(__FILE__) + "/command_*.rb"].each do |file|
  puts file

end

