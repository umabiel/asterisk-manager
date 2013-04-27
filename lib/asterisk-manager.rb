require 'find'

root = File.join(File.dirname(__FILE__), 'asterisk-manager')
Find.find(root) do |file|
  next unless File.extname(file) == '.rb'
  require file
end
