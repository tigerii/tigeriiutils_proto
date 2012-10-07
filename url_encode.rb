#!/usr/bin/env ruby

require 'kconv'

print "Shift-JIS: "
ARGV[0].tosjis.each_byte{|char|
  print "%",char.to_s(16)
}
print "\n"

print "EUC-JP   : "
ARGV[0].toeuc.each_byte{|char|
  print "%",char.to_s(16)
}
print "\n"

print "UTF-8    : "
ARGV[0].toutf8.each_byte{|char|
  print "%",char.to_s(16)
}
print "\n"
