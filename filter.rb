
require 'csv'
require './merge_helper'
require 'pry'

# Here we want to select only the email and token columns from a CSV and then output it as a new file

# Arguments:
# 1) CSV to be filtered
# 2) Output filename
original_filename = ARGV.shift # The first argument is the CSV to be filtered
output_filename = ARGV.shift # The second argument is the filename of the new file to be output

MergeHelpers.output_table output_filename, MergeHelpers.select_only_columns(original_filename, ['token', 'email']) # output_table requires a name for the file and an array of csv files to append

# todo: It seems to me that calling these methods using the module name (MergeHelpers) is a bit cumbersome; I'm sure there's a better way to do this.

binding.pry

