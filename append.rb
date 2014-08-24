
require 'csv'
require './merge_helper'
require 'pry'

# We don't need to do the gymnastics we were doing earlier by extracting a list from a list and then creating a list...this is already an array!

# So the format of this script is as follows--any number of filenames with the last filename being the name of the file that is to be output

output_filename = ARGV.pop # The last argument is the title

MergeHelpers.output_table output_filename, MergeHelpers.append_csv_files(ARGV) # output_table requires a name for the file and an array of csv files to append

binding.pry








