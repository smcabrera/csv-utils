#! /usr/bin/env ruby

# Let's just see if we can get this argument thing figured out--just print out the argument that's listed

# So it looks like ruby represents ARGV as an array and we're popping out the first item to be our arg1
argstring = ""
ARGV.each {|arg| argstring += arg}
puts argstring
